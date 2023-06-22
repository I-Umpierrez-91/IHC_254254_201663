const knexfile = require("../../knexfile");
const knex = require("knex")(knexfile);
const { createUser } = require('./auth.service');

async function createCompany(
  firstName,
  lastName,
  email,
  password,
  companyName,
  passwordSalt
) {
  const company = {
    name: companyName,
  };

  
  // Start a transaction
  const trx = await knex.transaction();
  
  try {
    // Insert user data into 'companies' table
    const companyId = await trx("companies").insert(company);

    const user = {
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      companyId: companyId,
      passwordSalt: passwordSalt,
      role: 'admin',
    };

    const userId = await trx("users").insert(user);
    // Commit the transaction
    await trx.commit();

    // Return the inserted user ID
    return userId[0];
  } catch (error) {
    // Rollback the transaction in case of error
    await trx.rollback(error);

    // Throw the error
    return error;
  }
}

async function getCompanyById(id) {
  try {
    const company = await knex
      .select("*")
      .from("companies")
      .where("id", "=", id);
    return company[0];
  } catch (error) {
    return error;
  }
}

async function getCompanyByName(name) {
    try {
      const company = await knex
        .select("*")
        .from("companies")
        .where("name", "=", name);
      return company[0];
    } catch (error) {
      return error;
    }
  }

module.exports = {
  createCompany,
  getCompanyById,
  getCompanyByName
};
