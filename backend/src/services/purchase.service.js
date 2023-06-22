const knexfile = require('../../knexfile');
// eslint-disable-next-line import/order
const knex = require('knex')(knexfile);
const { tableNames } = require('../persistence/knex/tableNames');

async function createPurchase(provider, purchaseDetails, totalCost) {
  const purchase = {
    provider,
    totalCost,
  };

  const trx = await knex.transaction();

  try {
    const trxPurchaseId = await trx(tableNames.PURCHASES_TABLE).insert(
      purchase
    );

    for (const currentPurchaseDetail of purchaseDetails) {
      const purchaseDetail = {
        purchaseId: trxPurchaseId[0],
        product: currentPurchaseDetail.productId,
        quantity: currentPurchaseDetail.quantity,
      };
      await trx(tableNames.PURCHASE_DETAILS_TABLE).insert(purchaseDetail);
      await trx(tableNames.PRODUCTS_TABLE)
        .where('id', currentPurchaseDetail.productId)
        .update({ stock: currentPurchaseDetail.newStockQuantity });
    }
    await trx.commit();

    return trxPurchaseId[0];
  } catch (error) {
    await trx.rollback(error);
    return new Error(error);
  }
}

module.exports = {
  createPurchase,
};
