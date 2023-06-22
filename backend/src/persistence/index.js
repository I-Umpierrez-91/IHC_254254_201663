const knex = require('./knex/knex');
const { tableNames } = require('./knex/tableNames');

module.exports = {
  knex,
  tableNames,
};
