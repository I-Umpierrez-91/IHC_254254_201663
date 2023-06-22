/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function(knex) {
  return knex.schema.table('products', function(table) {
    table.renameColumn('quantity', 'stock');
  });
};

exports.down = function(knex) {
  return knex.schema.table('products', function(table) {
  table.renameColumn('stock', 'quantity');
  });
};
