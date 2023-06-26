const { tableNames } = require('../tableNames');

/**
 * @param { import('knex').Knex } knex
 * @returns { Promise<void> }
 */
exports.up = async (knex) => {
  await knex.schema.table(tableNames.SALES_TABLE, (table) => {
    table.double('latitude');
    table.double('longitude');
  });
};

/**
 * @param { import('knex').Knex } knex
 * @returns { Promise<void> }
 */
exports.down = (knex) => knex.schema.table(tableNames.SALES_TABLE, (table) => {
  table.dropColumn('latitude');
  table.dropColumn('longitude');
});
