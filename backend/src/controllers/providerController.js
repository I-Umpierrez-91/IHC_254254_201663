const {
  createProvider,
  getProviders,
  getProviderById,
  deleteProvider,
  updateProvider,
} = require('../services/provider.service');

// Create Provider
// eslint-disable-next-line consistent-return
exports.post = async (req, res, next) => {
  try {
    // eslint-disable-next-line object-curly-newline
    const { name, email, address, phone } = req.body;
    const provider = await createProvider(
      res.locals.companyId,
      name,
      email,
      address,
      phone
    );
    res.status(201).json(provider);
  } catch (error) {
    return next(error);
  }
};

// Get Provider
exports.get = async (req, res, next) => {
  const { id } = req.params;
  const provider = await getProviderById(res.locals.companyId, id);
  if (provider) {
    res.json(provider);
  } else {
    next(new Error());
  }
};

// Get Providers
exports.getAll = async (req, res, next) => {
  const provider = await getProviders(res.locals.companyId);
  if (provider) {
    res.json(provider);
  } else {
    next(new Error());
  }
};

// Delete Provider
exports.delete = async (req, res, next) => {
  const { id } = req.params;
  try {
    await deleteProvider(res.locals.companyId, id);
    res.json(`Proveedor con id ${id} fue eliminado de manera exitosa.`);
  } catch (error) {
    next(new Error());
  }
};

// Update Provider
exports.patch = async (req, res, next) => {
  try {
    // eslint-disable-next-line object-curly-newline
    const { name, email, address, phone } = req.body;

    const provider = await updateProvider(
      res.locals.companyId,
      name,
      email,
      address,
      phone
    );

    res.json(provider);
  } catch (error) {
    next(new Error());
  }
};

// Get ProviderById
exports.getProviderById = async (companyId, id) => {
  const provider = await getProviderById(companyId, id);
  if (provider) {
    return provider;
  } else {
    throw new Error('No existe un proveedor con id ' + id + ' registrado');
  }
};
