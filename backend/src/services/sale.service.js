const knexfile = require('../../knexfile');
// eslint-disable-next-line import/order
const knex = require('knex')(knexfile);
const { tableNames } = require('../persistence/knex/tableNames');

async function createSale(client, saleDate, saleDetails, totalCost, latitude, longitude) {
  const sale = {
    client,
    saleDate,
    totalCost,
    latitude,
    longitude,
  };

  const trx = await knex.transaction();

  try {
    console.log(sale);
    const trxSaleId = await trx(tableNames.SALES_TABLE).insert(sale);

    for (const currentSaleDetail of saleDetails) {
      const saleDetail = {
        saleId: trxSaleId[0],
        product: currentSaleDetail.productId,
        quantity: currentSaleDetail.quantity,
      };
      await trx(tableNames.SALE_DETAILS_TABLE).insert(saleDetail);
      await trx(tableNames.PRODUCTS_TABLE)
        .where('id', currentSaleDetail.productId)
        .update({ stock: currentSaleDetail.newStockQuantity });
    }
    await trx.commit();

    return trxSaleId[0];
  } catch (error) {
    await trx.rollback(error);
    return new Error(error);
  }
}

module.exports = {
  createSale,
};
