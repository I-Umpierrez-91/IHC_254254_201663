const knexfile = require('../../knexfile');
// eslint-disable-next-line import/order
const knex = require('knex')(knexfile);
const { tableNames } = require('../persistence/knex/tableNames');
const { errors } = require('../errors');

const providers = (companyId, transaction) =>
  (transaction || knex)(tableNames.PROVIDERS_TABLE)
    .where('deleted', false)
    .where('companyId', companyId);

async function createProvider(companyId, name, email, address, phone) {
  const provider = {
    name,
    email,
    address,
    phone,
    companyId,
  };

  // Start a transaction
  const trx = await knex.transaction();

  try {
    // Insert provider data into 'providers' table
    const providerId = await providers(companyId, trx).insert(provider);

    // Commit the transaction
    await trx.commit();

    // Return the inserted provider ID
    return providerId[0];
  } catch (error) {
    // Rollback the transaction in case of error
    await trx.rollback(error);

    // Throw the error
    // throw error;
    return error;
  }
}

async function getProviders(companyId) {
  try {
    return providers(companyId);
  } catch (error) {
    return new Error(error);
  }
}
const getProviderById = async (companyId, id) => {
  const provider = await providers(companyId).where('id', id).first();

  if (!provider) {
    throw new errors.NotFoundError('Provider not found');
  }

  return provider;
};

const deleteProvider = async (companyId, id) =>
  knex.transaction(async (transaction) => {
    const deleted = await providers(companyId, transaction)
      .where('id', id)
      .update({ deleted: true });

    if (!deleted) {
      throw new errors.NotFoundError('Provider not found');
    }
  });

async function updateProvider(companyId, name, email, address, phone) {
  const newProviderInfo = {};
  if (name) {
    newProviderInfo.name = name;
  }
  if (email) {
    newProviderInfo.email = email;
  }
  if (address) {
    newProviderInfo.address = address;
  }
  if (phone) {
    newProviderInfo.phone = phone;
  }

  try {
    const updateState = await knex(tableNames.PROVIDERS_TABLE)
      .update(newProviderInfo)
      .where('email', '=', email)
      .where('deleted', false)
      .where('companyId', companyId);
    if (updateState === 1) {
      return `El proveedor con mail ${email} fue modificado con exito`;
    }
    return `No se pudieron modificar los datos del provedoor con mail: ${email}`;
  } catch (error) {
    return error;
  }
}

module.exports = {
  createProvider,
  getProviders,
  getProviderById,
  deleteProvider,
  updateProvider,
};
