const { knex } = require('../persistence');

const checkDatabaseStatus = async () => {
  await knex.raw('SELECT 1');
};

module.exports = {
  checkDatabaseStatus,
};
