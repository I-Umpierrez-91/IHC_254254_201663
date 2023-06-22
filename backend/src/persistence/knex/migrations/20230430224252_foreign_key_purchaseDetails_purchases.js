/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
  return knex.schema.table('purchaseDetails', (t) => {
    t.integer('purchaseId')
      .unsigned()
      .notNullable()
      .references('purchases.id')
      .alter();
  });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
  return knex.schema.table('purchaseDetails', (t) => {
    t.integer('purchaseId').notNullable().alter();
  });
};
