class User {
  constructor({
    firstName,
    lastName,
    email,
    password,
    companyId,
    role,
  }) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.password = password;
    this.companyId = companyId;
    this.role = role;
  }
}

module.exports = {
  User,
};
