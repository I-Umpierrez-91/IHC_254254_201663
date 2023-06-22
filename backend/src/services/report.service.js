const knexfile = require("../../knexfile");
const knex = require("knex")(knexfile);

async function getPurchasesByProvider(
  startDate,
  endDate,
  companyId,
  providerId
) {
  try {
    query = 'CALL ' + process.env.RDS_DB_NAME + '.PurchasesByProvider(?, ?, ?, ?)';
    const results = await knex.raw(query, [
      providerId,
      startDate,
      endDate,
      companyId,
    ]);

    return results;
  } catch (error) {
    throw error;
  };
}

async function getTopSellingProducts(
  companyId
) {
  try {
    query = 'CALL ' + process.env.RDS_DB_NAME + '.TopSellingProductsByCompany(?)';
    const results = await knex.raw(query, [
      companyId,
    ]);
    return results;
  } catch (error) {
    throw error;
  };
}

async function getSalesByDate(
  companyId,
  startDate,
  endDate
) {
  try {
    query = 'CALL ' + process.env.RDS_DB_NAME + '.SalesByDate(?, ?, ?)';
    const results = await knex.raw(query, [
      companyId,
      startDate,
      endDate
    ]);
    return results;
  } catch (error) {
    throw error;
  };
}

async function getSalesByDateByProduct(
  companyId,
  startDate,
  endDate
) {
  try {
    query = 'CALL ' + process.env.RDS_DB_NAME + '.SalesByDateByProduct(?, ?, ?)';
    const results = await knex.raw(query, [
      companyId,
      startDate,
      endDate
    ]);
    return results;
  } catch (error) {
    throw error;
  };
}

module.exports = {
  getPurchasesByProvider,
  getTopSellingProducts,
  getSalesByDate,
  getSalesByDateByProduct
};
