const { v4: uuidv4 } = require('uuid');
const {
  createProduct,
  listProducts,
  getProductById,
  updateProduct,
  getProductsByIds,
  deleteProduct,
} = require('../services/product.service');
const { Product } = require('../models/product');

exports.post = async (req, res, next) => {
  try {
    const {
      name,
      description,
      price,
      stock,
    } = req.body;
    const product = new Product({
      name,
      description,
      price,
      stock,
      companyId: res.locals.companyId,
    });

    await product.validate();

    const createdProduct = await createProduct(res.locals.companyId, product);
    const jsonResponse = await createdProduct.json();
    return res.status(201)
      .json(jsonResponse);
  } catch (error) {
    return next(error);
  }
};

exports.list = async (req, res, next) => {
  try {
    const products = await listProducts(res.locals.companyId);
    const jsonResponse = await Promise.all(
      products.map(
        (product) => product.json(),
      ),
    );
    res.status(products ? 200 : 204)
      .json(jsonResponse);
  } catch (error) {
    next(error);
  }
};

exports.get = async (req, res, next) => {
  try {
    const { productId } = req.params;
    const product = await getProductById(res.locals.companyId, productId);
    const jsonResponse = await product.json();
    res.status(200)
      .json(jsonResponse);
  } catch (error) {
    next(error);
  }
};

exports.put = async (req, res, next) => {
  try {
    const { productId } = req.params;
    const {
      name,
      description,
      price,
      stock,
    } = req.body;
    const product = new Product({
      id: productId,
      name,
      description,
      price,
      stock,
      companyId: res.locals.companyId,
    });

    await product.validate();

    const updatedProduct = await updateProduct(res.locals.companyId, productId, product);

    const jsonResponse = await updatedProduct.json();
    return res.status(200)
      .json(jsonResponse);
  } catch (error) {
    return next(error);
  }
};

exports.getProductsByIds = async (companyId, productIds) => {
  try {
    return await getProductsByIds(companyId, productIds);
  } catch (error) {
    throw new Error(error);
  }
};

exports.delete = async (req, res, next) => {
  try {
    const { productId } = req.params;
    await deleteProduct(res.locals.companyId, productId);
    return res.status(204)
      .json();
  } catch (error) {
    return next(error);
  }
};


