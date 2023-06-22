const yup = require('yup');

const saleSchema = yup.object({
  client: yup.number().positive().required(),
  saleDate: yup.date().required(),
  totalCost: yup.number().positive().required(),
});

class Sale {
  // eslint-disable-next-line object-curly-newline
  constructor({ id, client, saleDate, totalCost }) {
    this.id = id;
    this.client = client;
    this.saleDate = saleDate;
    this.totalCost = totalCost;
  }

  async validate() {
    await saleSchema.validate(this, {
      strict: true,
      abortEarly: false,
    });
  }
}

module.exports = {
  Sale,
};
