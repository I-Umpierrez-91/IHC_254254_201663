const { checkDatabaseStatus } = require('../services/health.service');

const status = {
  OK: 'OK',
  ERROR: 'ERROR',
};

exports.get = async (req, res) => {
  const databaseHealth = { status: status.OK };

  try {
    await checkDatabaseStatus();
  } catch (error) {
    databaseHealth.status = status.ERROR;
    databaseHealth.error = error.message;
  }

  const okHealth = databaseHealth.status === status.OK;

  res.status(okHealth ? 200 : 500)
    .json({
      database: databaseHealth,
    });
};
