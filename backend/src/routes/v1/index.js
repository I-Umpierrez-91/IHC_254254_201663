const express = require('express');
const {
  authenticateToken,
} = require('../../controllers/authController');
const providerRoutes = require('./providers.route');
const authRoutes = require('./auth.route');
const productsRoute = require('./products.route');
const purchasesRoutes = require('./purchases.route');
const salesRoutes = require('./sales.route');

// eslint-disable-next-line new-cap
const router = express.Router();

router.use('/auth', authRoutes);
router.use('/providers', authenticateToken, providerRoutes);
router.use('/products', authenticateToken, productsRoute);
router.use('/purchases', authenticateToken, purchasesRoutes);
router.use('/sales', authenticateToken, salesRoutes);

module.exports = router;
