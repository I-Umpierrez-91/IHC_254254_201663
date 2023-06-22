const { tableNames } = require('../tableNames');

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = (knex) => knex.schema.createTable(tableNames.PRODUCTS_TABLE, (table) => {
  table.increments();
  table.string('name', 255).notNullable();
  table.text('description');
  table.string('image', 500);
  table.float('price').notNullable();
  table.bigint('quantity').notNullable();
});

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = (knex) => knex.schema.dropTable(tableNames.PRODUCTS_TABLE);
