/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
  return knex.schema.createTable('sales', (tb) => {
    tb.increments();
    tb.integer('client', 200);
    tb.date('saleDate', 200);
    tb.integer('totalCost', 200);
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
  return knex.schema.dropTable('sales');
};
