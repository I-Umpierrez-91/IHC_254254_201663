/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function (knex) {
  return knex.schema.createTable("providers", (tb) => {
    tb.increments();
    tb.string("name", 200);
    tb.string("email", 200).notNullable().unique();
    tb.string("address", 200);
    tb.string("phone", 100);
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
exports.down = function (knex) {
  return knex.schema.dropTable("providers");
};
