const yup = require('yup');

const productSchema = yup.object({
  name: yup.string()
    .required(),
  description: yup.string(),
  image: yup.string()
    .nullable(),
  price: yup.number()
    .positive()
    .required(),
  stock: yup.number()
    .positive()
    .integer()
    .required(),
});

class Product {
  constructor({
    id,
    name,
    description,
    image,
    price,
    stock,
    companyId,
    qrCode,
  }) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.image = image;
    this.price = price;
    this.stock = stock;
    this.companyId = companyId;
    this.qrCode = qrCode;
  }

  async validate() {
    await productSchema.validate(this, {
      strict: true,
      abortEarly: false,
    });
  }


  async json() {
    return {
      id: this.id,
      name: this.name,
      description: this.description,
      price: this.price,
      stock: this.stock,
      qrCode: this.qrCode,
    };
  }
}

module.exports = {
  Product,
};
