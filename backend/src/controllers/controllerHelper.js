const productController = require('./productController');

const getProductByIds = async (companyId, productQuantityDetails) => {
  const productIds = productQuantityDetails.map(
    (currentProductQuantity) => currentProductQuantity.productId
  );
  return productController.getProductsByIds(companyId, productIds);
};

const addNewStockQuantity = async (
  productQuantityDetails,
  products,
  increase
) => {
  for (const productQuantityDetail of productQuantityDetails) {
    const currentProductStock = products.find(
      (currentProduct) => currentProduct.id === productQuantityDetail.productId
    ).stock;
    if (increase) {
      productQuantityDetail.newStockQuantity =
        currentProductStock + productQuantityDetail.quantity;
    } else {
      if (currentProductStock < productQuantityDetail.quantity) {
        throw new Error(
          `No existe suficiente stock para la cantidad de ${productQuantityDetail.name} solicitado.`
        );
      }
      productQuantityDetail.newStockQuantity =
        currentProductStock - productQuantityDetail.quantity;
    }
  }
  return productQuantityDetails;
};

const getTotalCost = async (productQuantityDetails, products) => {
  let totalCost = 0;
  for (const productQuantityDetail of productQuantityDetails) {
    const currentProductPrice = products.find(
      (currentProduct) => currentProduct.id === productQuantityDetail.productId
    ).price;
    totalCost += productQuantityDetail.quantity * currentProductPrice;
  }
  return totalCost;
};

module.exports = {
  getProductByIds,
  addNewStockQuantity,
  getTotalCost,
};
