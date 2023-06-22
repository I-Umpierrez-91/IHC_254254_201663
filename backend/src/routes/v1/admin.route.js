const express = require('express');
const {
  inviteUser,
} = require('../../controllers/authController');

const router = express.Router();

// Endpoint de inicio de sesión
router.post('/invite', inviteUser);

module.exports = router;
