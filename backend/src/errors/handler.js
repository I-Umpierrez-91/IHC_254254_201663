const { ValidationError } = require('yup');
const { NotFoundError } = require('./custom');

// eslint-disable-next-line no-unused-vars
const errorHandler = (err, req, res, next) => {
  if (err instanceof ValidationError) {
    return res.status(400).json(err);
  }

  if (err instanceof NotFoundError) {
    return res.status(404).json({
      message: err.message,
    });
  }

  // eslint-disable-next-line no-console
  console.error('Unexpected error:', err);

  return res.status(500).json({
    message: `Unexpected error: ${err.message}`,
  });
};

module.exports = {
  errorHandler,
};
