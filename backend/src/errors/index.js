const { errorHandler } = require('./handler');
const { NotFoundError } = require('./custom');

module.exports = {
  errorHandler,
  errors: {
    NotFoundError,
  },
};
