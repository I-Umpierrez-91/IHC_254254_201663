/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.up = function(knex) {
    return knex.schema.table('users', function(t) {
        t.integer('companyId').unsigned().notNullable().references('companies.id').alter();
        t.string("role", 50).defaultTo("user");
    });
};

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
exports.down = function(knex) {
  return knex.schema.table('users', function(t) {
      t.dropColumn('role');
      t.integer('companyId').notNullable().alter();
    });
};
