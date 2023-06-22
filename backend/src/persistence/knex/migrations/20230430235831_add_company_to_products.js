const { tableNames } = require('../tableNames');

/**
 * @param { import('knex').Knex } knex
 * @returns { Promise<void> }
 */
exports.up = async (knex) => {
  await knex(tableNames.PRODUCTS_TABLE).del();
  await knex.schema.table(tableNames.PRODUCTS_TABLE, (table) => {
    table.integer('companyId')
      .unsigned()
      .notNullable()
      .references('companies.id');
  });
};

/**
 * @param { import('knex').Knex } knex
 * @returns { Promise<void> }
 */
exports.down = (knex) => knex.schema.table(tableNames.PRODUCTS_TABLE, (table) => {
  table.dropColumn('companyId');
});
