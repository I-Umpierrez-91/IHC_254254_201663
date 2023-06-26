const { tableNames } = require('../tableNames');

/**
 * @param { import('knex').Knex } knex
 * @returns { Promise<void> }
 */
exports.up = async (knex) => {
  await knex.schema.table(tableNames.PRODUCTS_TABLE, (table) => {
    table.string('qrCode', 2000);
  });
};

/**
 * @param { import('knex').Knex } knex
 * @returns { Promise<void> }
 */
exports.down = (knex) => knex.schema.table(tableNames.PRODUCTS_TABLE, (table) => {
  table.dropColumn('qrCode');
});
