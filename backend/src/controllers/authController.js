const jwt = require('jsonwebtoken');
const crypto = require('crypto');
const nodemailer = require('nodemailer');

const {
  getUser,
} = require('../services/auth.service');
const {
  createCompany,
  getCompanyByName,
} = require('../services/company.service');

function hashPassword(password, salt) {
  const hash = crypto.createHash('sha256');
  hash.update(password);
  hash.update(salt);
  return hash.digest('hex');
}

exports.authenticateToken = async (req, res, next) => {
  const authHeader = req.headers.authorization;
  const token = authHeader && authHeader.split(' ')[1];

  if (token == null) {
    return res
      .status(401)
      .json({ message: 'Se requiere un token de autenticación' });
  }

  jwt.verify(token, process.env.JWT_SECRET_KEY, (err, tokenData) => {
    if (err) {
      return res
        .status(401)
        .json({ message: 'Token de autenticación inválido' });
    }

    const {
      id: userId,
      companyId,
      role,
    } = tokenData;

    res.locals.userId = userId;
    res.locals.companyId = companyId;
    res.locals.role = role;
    next();
  });
};

exports.login = async (req, res, next) => {
  const {
    email,
    password,
  } = req.body;

  try {
    // Verificar si el email y la contraseña son válidos en la base de datos
    const user = await getUser(email);

    let hashedPassword = null;
    if (user) {
      hashedPassword = hashPassword(password, user.passwordSalt);
    }

    // Si los datos son válidos, generar un token JWT y devolverlo en la respuesta
    if (hashedPassword && user.password === hashedPassword) {
      const token = jwt.sign({
        id: user.id,
        email: user.email,
        companyId: user.companyId,
        role: user.role,
      }, process.env.JWT_SECRET_KEY, {
        expiresIn: '12h',
      });
      res.json({
        token,
        user,
      });
    } else {
      // Si los datos no son válidos, devolver un error de autenticación
      res
        .status(401)
        .json({
          message: 'El usuario no existe o las credenciales son incorrectas',
        });
    }
  } catch (error) {
    next(error);
  }
};

exports.companySignup = async (req, res, next) => {
  const {
    firstName,
    lastName,
    email,
    password,
    companyName,
  } = req.body.adminData;

  try {
    const existingUser = await getUser(email);
    if (existingUser) {
      res.status(401)
        .json('El email ya está registrado en el sistema.');
      return;
    };
    const existingCompany = await getCompanyByName(companyName);
    if (existingCompany) {
      res.status(401)
        .json('Ya existe una empresa con ese nombre en el sistema.');
      return;
    };

    const salt = crypto.randomBytes(16)
      .toString('hex');

    const hashedPassword = hashPassword(password, salt);

    // Insertar datos en la base de datos
    const user = await createCompany(
      firstName,
      lastName,
      email,
      hashedPassword,
      companyName,
      salt,
    );
    res.status(201)
      .json({ user });
  } catch (error) {
    return next(error);
  }
};


