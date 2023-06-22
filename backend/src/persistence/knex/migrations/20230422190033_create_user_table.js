/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function(knex) {
  return knex.schema.createTable("users", (tb) => {
    tb.increments();
    tb.string("email", 200).notNullable().unique();
    tb.string("password", 200).notNullable();
    tb.string("firstName", 200);
    tb.string("lastName", 200);
    tb.string("passwordSalt", 200);
    tb.integer("companyId").notNullable();
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
  return knex.schema.dropTable("users");
};
