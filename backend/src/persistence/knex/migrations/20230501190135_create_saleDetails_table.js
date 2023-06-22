/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
  return knex.schema.createTable('saleDetails', (tb) => {
    tb.increments();
    tb.integer('saleId', 200).notNullable();
    tb.integer('product', 200);
    tb.integer('quantity', 200);
    tb.timestamp('createdAt').defaultTo(knex.fn.now());
    tb.timestamp('updatedAt').defaultTo(
      knex.raw('CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP')
    );
  });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function (knex) {
  return knex.schema.dropTable('saleDetails');
};
