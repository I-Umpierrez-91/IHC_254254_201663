import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../factory_service.dart';
import '../models/product.dart';

class ProductsScreen extends StatefulWidget {
  ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late List<Product> products = [];
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late String _image;
  late double _price;
  late int _stock;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final factory = FactoryServices().getProductService();
    products = await factory.getProducts() as List<Product>;
    setState(() {}); // Trigger a rebuild after loading the products
  }

  Future<void> _openCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: products != null
          ? ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    product.description,
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Price: \$${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'Stock: ${product.stock}',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add Product',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: _openCamera,
                            icon: Icon(Icons.camera_alt),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _name = value!;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _description = value!;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Image',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an image URL';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _image = value!;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Price',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a price';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid price';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _price = double.parse(value!);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Stock',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a stock quantity';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid stock quantity';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _stock = int.parse(value!);
                        },
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // Add your logic to save the product
                            // using the entered values (_name, _description, _image, _price, _stock)
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Add'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
