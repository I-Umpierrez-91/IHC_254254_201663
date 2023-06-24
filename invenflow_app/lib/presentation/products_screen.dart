import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invenflow_app/presentation/widgets/error_message.dart';
import 'package:invenflow_app/presentation/widgets/success_message.dart';

import '../factory_service.dart';
import '../models/product.dart';
import './widgets/image_page.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late List<Product> products = [];
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

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

  Uint8List dataUrlToBytes(String? dataUrl) {
    if (dataUrl == null) {
      return Uint8List(0);
    } else {
      final byteData = Base64Decoder().convert(dataUrl.split(",").last);
      return Uint8List.fromList(byteData);
    }
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
                String sid = product.id.toString();
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ImagePage(
                                              id: sid,
                                              imageItem: dataUrlToBytes(
                                                  product.qrCode)),
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: sid,
                                      child: Image.memory(
                                        dataUrlToBytes(product.qrCode),
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  product.description,
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Price: \$${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Stock: ${product.stock}',
                                  style: const TextStyle(fontSize: 14.0),
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
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add Product',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: priceController,
                      decoration: const InputDecoration(
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
                    ),
                    TextFormField(
                      controller: stockController,
                      decoration: const InputDecoration(
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
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Verify that the text fields are completed.
                        if (nameController.text.isEmpty ||
                            descriptionController.text.isEmpty ||
                            priceController.text.isEmpty ||
                            stockController.text.isEmpty) {
                          showErrorDialog(
                              context, 'Por favor ingresar todos los datos.');
                        } else {
                          final factory = FactoryServices().getProductService();
                          Product newProduct = Product(
                              name: nameController.text,
                              description: descriptionController.text,
                              price: int.parse(priceController.text),
                              stock: int.parse(stockController.text));
                          factory.createProduct(newProduct);
                          showSuccessDialog(
                              context,
                              'Producto creado de exitosamente.',
                              "toProductScreen");
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
