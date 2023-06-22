const { createPurchase } = require('../services/purchase.service');
const {
  getProductByIds,
  getTotalCost,
  addNewStockQuantity,
} = require('./controllerHelper');

// Create Purchase
exports.post = async (req, res, next) => {
  try {
    // eslint-disable-next-line object-curly-newline
    const {
      provider,
      purchaseDetails,
    } = req.body;
    const products = await getProductByIds(res.locals.companyId, purchaseDetails);
    const totalCost = await getTotalCost(purchaseDetails, products);
    const increaseStock = true;
    const purchaseDetailsWithStock = await addNewStockQuantity(
      purchaseDetails,
      products,
      increaseStock,
    );
    const purchaseId = await createPurchase(
      provider,
      purchaseDetailsWithStock,
      totalCost,
    );

    res.json(purchaseId);
  } catch (error) {
    next(error);
  }
};
