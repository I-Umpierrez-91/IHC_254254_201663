const qr = require('qrcode');
const {
  knex,
  tableNames,
} = require('../persistence');
const { Product } = require('../models/product');
const { errors } = require('../errors');

const products = (companyId, transaction) => (
  (transaction || knex)(tableNames.PRODUCTS_TABLE)
    .where('deleted', false)
    .where('companyId', companyId)
);

/**
 * Persists a product to the database
 *
 * @param companyId {number}
 * @param product {Product}
 * @returns {Promise<Product>}
 */
const createProduct = async (companyId, product) => knex.transaction(async (transaction) => {
  // TODO: Validate name unique together with business (https://mn201663.atlassian.net/browse/ASP2023-48)
  product.id = null; // eslint-disable-line no-param-reassign
  product.companyId = companyId; // eslint-disable-line no-param-reassign
  const [id] = await products(companyId, transaction)
    .insert(product);
  const qrCodeImage = await qr.toDataURL(String(id));
  await products(companyId, transaction).update({ qrCode: qrCodeImage }).where('id', id);

  return new Product(
    await products(companyId, transaction)
      .where('id', id)
      .first(),
  );
});

/**
 * List all products
 *
 * @param companyId {number}
 * @returns {Promise<Product[]>}
 */
// TODO: Filter by authenticated user (https://mn201663.atlassian.net/browse/ASP2023-54)
const listProducts = async (companyId) => {
  const productList = await products(companyId);
  return productList.map((productData) => new Product(productData));
};

/**
 * Get a product by id
 *
 * @param companyId {number}
 * @param id {number}
 * @returns {Promise<Product>}
 */
// TODO: Filter by authenticated user (https://mn201663.atlassian.net/browse/ASP2023-54)
const getProductById = async (companyId, id) => {
  const product = await products(companyId)
    .where('id', id)
    .first();

  if (!product) {
    throw new errors.NotFoundError('Product not found');
  }

  return new Product(product);
};

/**
 * Modifies a product from the database
 * @param companyId {number}
 * @param id {number}
 * @param product {Product}
 * @returns {Promise<Product>}
 */
const updateProduct = async (companyId, id, product) => knex.transaction(async (transaction) => {
  product.id = id; // eslint-disable-line no-param-reassign
  product.companyId = companyId; // eslint-disable-line no-param-reassign

  const updatedRows = await products(companyId, transaction)
    .where('id', id)
    .update(product);

  if (!updatedRows) {
    throw new errors.NotFoundError('Product not found');
  }

  return getProductById(companyId, id);
});

/**
 * Gets a list of products by ids
 * @param companyId {number}
 * @param productIds {Array<number>}
 * @returns {Promise<void>}
 */
const getProductsByIds = async (companyId, productIds) => {
  try {
    return products(companyId)
      .whereIn('id', productIds);
  } catch (error) {
    throw new Error(error);
  }
};

/**
 * Deletes a product from the database
 * @param companyId {number}
 * @param id {number}
 * @returns {Promise<void>}
 */
const deleteProduct = async (companyId, id) => knex.transaction(async (transaction) => {
  const deleted = await products(companyId, transaction)
    .where('id', id)
    .update({ deleted: true });

  if (!deleted) {
    throw new errors.NotFoundError('Product not found');
  }
});

module.exports = {
  createProduct,
  listProducts,
  getProductById,
  updateProduct,
  getProductsByIds,
  deleteProduct,
};
