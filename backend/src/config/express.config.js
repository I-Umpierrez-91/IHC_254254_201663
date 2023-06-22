const express = require('express');
const cors = require('cors');
const healthRoutes = require('../routes/health');
const routes = require('../routes/v1');
const { errorHandler } = require('../errors');

/**
 * Express instance
 * @public
 */
const app = express();

/**
 * App Configurations
 */

// Enable CORS requests
app.use(cors());

app.use(express.json());

// mount health routes
app.use('/health', healthRoutes);

// mount api v1 routes
app.use('/api/v1', routes);

// Add custom error handler (Must be at the end)
app.use(errorHandler);

module.exports = app;
