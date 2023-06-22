const knexfile = require("../../knexfile");
const knex = require("knex")(knexfile);

async function createUser(
  firstName,
  lastName,
  email,
  password,
  companyId,
  passwordSalt,
  role
) {
  const user = {
    firstName: firstName,
    lastName: lastName,
    email: email,
    password: password,
    companyId: companyId,
    passwordSalt: passwordSalt,
    role: role,
  };

  // Start a transaction
  const trx = await knex.transaction();

  try {
    // Insert user data into 'users' table
    const userId = await trx("users").insert(user);

    // Commit the transaction
    await trx.commit();

    // Return the inserted user ID
    return userId[0];
  } catch (error) {
    // Rollback the transaction in case of error
    await trx.rollback(error);

    // Throw the error
    throw error;
  }
}

async function getUser(email) {
  try {
    const user = await knex
      .select("*")
      .from("users")
      .where("email", "=", email).first();
    return user;
  } catch (error) {
    throw error;
  }
}

module.exports = {
  createUser,
  getUser,
};
