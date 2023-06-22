const { v4: uuidv4 } = require('uuid');
const { tableNames } = require('../tableNames');

/**
 * @param { import('knex').Knex } knex
 * @returns { Promise<void> }
 */
exports.up = async (knex) => {
  const productsWithoutImageIds = await knex(tableNames.PRODUCTS_TABLE)
    .whereNull('image')
    .pluck('id');

  await Promise.all(
    productsWithoutImageIds.map(
      (id) => knex(tableNames.PRODUCTS_TABLE)
        .where('id', id)
        .update({ image: `images/${Date.now()}_${uuidv4()}.jpg` }),
    ),
  );

  await knex.schema.table(tableNames.PRODUCTS_TABLE, (table) => {
    table.string('image', 500)
      .nullable()
      .unique()
      .alter();
  });
};

/**
 * @param { import('knex').Knex } knex
 * @returns { Promise<void> }
 */
exports.down = (knex) => knex.schema.table(tableNames.PRODUCTS_TABLE, (table) => {
  table.string('image', 500)
    .nullable()
    .alter();
  table.dropUnique('image');
});
