const { createSale } = require('../services/sale.service');
const {
  getProductByIds,
  getTotalCost,
  addNewStockQuantity,
} = require('./controllerHelper');

// Create Sale
exports.post = async (req, res, next) => {
  try {
    // eslint-disable-next-line object-curly-newline
    const {
      client,
      saleDate,
      saleDetails,
      latitude,
      longitude,
    } = req.body;
    const products = await getProductByIds(res.locals.companyId, saleDetails);
    const totalCost = await getTotalCost(saleDetails, products);
    const increaseStock = false;
    const saleDetailsWithStock = await addNewStockQuantity(
      saleDetails,
      products,
      increaseStock,
    );
    const saleId = await createSale(
      client,
      saleDate,
      saleDetailsWithStock,
      totalCost,
      latitude,
      longitude,
    );

    res.json(saleId);
  } catch (error) {
    next(error);
  }
};
