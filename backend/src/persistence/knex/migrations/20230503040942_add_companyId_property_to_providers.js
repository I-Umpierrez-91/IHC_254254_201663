const { tableNames } = require('../tableNames');

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = async (knex) => {
  await knex.schema.table(tableNames.PROVIDERS_TABLE, (table) => {
    table
      .integer('companyId')
      .unsigned()
      .notNullable()
      .references('companies.id');
  });
};

/**companyId
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = (knex) =>
  knex.schema.table(tableNames.PROVIDERS_TABLE, (table) => {
    table.dropColumn('companyId');
  });
