const yup = require('yup');

const saleSchema = yup.object({
  client: yup.number().positive().required(),
  saleDate: yup.date().required(),
  totalCost: yup.number().positive().required(),
  latitude: yup.number(),
  longitude: yup.number(),
});

class Sale {
  // eslint-disable-next-line object-curly-newline
  constructor({ id, client, saleDate, totalCost, latitude, longitude }) {
    this.id = id;
    this.client = client;
    this.saleDate = saleDate;
    this.totalCost = totalCost;
    this.latitude = latitude;
    this.longitude = longitude;
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
