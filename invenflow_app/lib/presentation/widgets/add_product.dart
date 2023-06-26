import 'package:flutter/material.dart';

import '../../models/product.dart';

class AddProductCard extends StatelessWidget {
  final TextEditingController quantityController = TextEditingController();

  final Product product;

  AddProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Color.fromARGB(58, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Cantidad',
              ),
            ),
            SizedBox(height: 16.0),
            Text(product.name),
            SizedBox(height: 16.0),
            Text(
              'Precio: \$${product.price}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, null); // Cancelar
                  },
                  child: Text('Cancelar'),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    final quantity = int.tryParse(quantityController.text) ?? 0;
                    final result = AddProductCardResult(
                      quantity: quantity
                    );
                    Navigator.pop(context, result); // Aceptar
                  },
                  child: Text('Aceptar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddProductCardResult {
  final int quantity;

  AddProductCardResult({
    required this.quantity,
  });
}

