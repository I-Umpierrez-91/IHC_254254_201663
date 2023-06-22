const yup = require('yup');

const puchaseSchema = yup.object({
  purchaseDate: yup.date().required(),
  provider: yup.number().positive().required(),
  products: yup.array(),
  totalCost: yup.number().positive().required(),
});

class Purchase {
  // eslint-disable-next-line object-curly-newline
  constructor({ id, purchaseDate, provider, products, totalCost }) {
    this.id = id;
    this.purchaseDate = purchaseDate;
    this.provider = provider;
    this.products = products;
    this.totalCost = totalCost;
  }

  async validate() {
    await puchaseSchema.validate(this, {
      strict: true,
      abortEarly: false,
    });
  }
}

module.exports = {
  Purchase,
};
