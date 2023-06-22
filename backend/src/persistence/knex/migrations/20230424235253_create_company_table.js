/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function(knex) {
  return knex.schema.createTable("companies", (tb) => {
      tb.increments();
      tb.string("name", 200).notNullable().unique();
      tb.timestamp("createdAt").defaultTo(knex.fn.now());
      tb.timestamp("updatedAt").defaultTo(
        knex.raw("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
      );
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function(knex) {
  return knex.schema.dropTable("companies");
};
