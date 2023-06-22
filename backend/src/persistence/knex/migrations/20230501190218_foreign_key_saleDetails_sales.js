/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
  return knex.schema.table('saleDetails', (t) => {
    t.integer('saleId')
      .unsigned()
      .notNullable()
      .references('sales.id')
      .alter();
  });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
  return knex.schema.table('saleDetails', (t) => {
    t.integer('saleId').notNullable().alter();
  });
};
