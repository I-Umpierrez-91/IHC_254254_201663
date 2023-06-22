const express = require('express');
const {
  login,
  companySignup,
} = require('../../controllers/authController');

const router = express.Router();

// Endpoint de inicio de sesión
router.post('/login', login);

router.post('/company-signup', companySignup);

module.exports = router;
