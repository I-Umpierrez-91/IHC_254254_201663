import 'package:flutter/material.dart';
import 'package:invenflow_app/presentation/qr_payment_screen.dart';
import 'package:invenflow_app/presentation/qr_scanner_screen.dart';
import 'package:invenflow_app/presentation/widgets/add_product.dart';

import '../factory_service.dart';
import '../models/order_detail.dart';
import '../models/product.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({super.key});

  @override
  _PurchasesScreenState createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  late List<OrderDetail> orderDetails = [];
  late Product product;
  double progress = 0.33;
  bool nextPressed = false;
  double saleTotal = 0.0;

  Future<void> loadProduct(String productId) async {
    final factory = FactoryServices().getProductService();
    product = await factory.getProduct(productId) as Product;
    setState(() {}); // Trigger a rebuild after loading the products
  }

  void next() {
    if (orderDetails.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Agrega al menos un producto'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    setState(() {
      nextPressed = true;
      saleTotal = calculatePurchaseTotal();
      progress = 0.66;
    });
  }

  void back() {
    setState(() {
      nextPressed = false;
      progress = 0.33;
    });
  }

  void cancel() {
    Navigator.pop(context);
  }

  double calculatePurchaseTotal() {
    // Lógica para calcular el total de la venta
    // Puedes reemplazar esta implementación con la lógica adecuada a tu aplicación
    double total = 0.0;
    for (OrderDetail orderDetail in orderDetails) {
      // Supongamos que cada producto tiene un precio de $10
      total += orderDetail.subtotal;
    }
    return total;
  }

  void removeElement(int? id) {
    setState(() {
      orderDetails.removeAt(id!);
      saleTotal = calculatePurchaseTotal();
    });
  }

  Future<AddProductCardResult?> _showPopupCard(BuildContext context) async {
    final result = await showDialog<AddProductCardResult?>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddProductCard(product: product),
    );
    if (result != null) {
      return result;
    }
  }

  Future showPopupMessage(BuildContext context, String message) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nueva Compra'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void confirm(BuildContext context) async {
    setState(() {
      progress = 1.0;
    });
    final purchaseFactory = FactoryServices().getPurchasesService();
    final result = await purchaseFactory.createPurchase(orderDetails);
    print(result);
    if (result == 200) {
      await showPopupMessage(context, 'Compra registrada con éxito');
      Navigator.pop(context);
    } else {
      showPopupMessage(context, 'Error al registrar la compra');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Compra'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Productos: ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              itemCount: orderDetails.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(orderDetails[index].product.name),
                  subtitle: Text(
                    'Cantidad: ${orderDetails[index].quantity} - Precio: \$${orderDetails[index].subtotal}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => removeElement(index),
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (!nextPressed)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: FloatingActionButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QRScannerScreen()),
                    );
                    if (result != null) {
                      await loadProduct(result);
                      AddProductCardResult? newLine =
                          await _showPopupCard(context);
                      if (newLine != null) {
                        setState(() {
                          orderDetails.add(OrderDetail(
                            product: product,
                            quantity: newLine.quantity,
                            subtotal: newLine.quantity * product.price,
                          ));
                        });
                      }
                    }
                    ;
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          const SizedBox(height: 16),
          if (nextPressed)
            Padding(
              padding: const EdgeInsets.only(bottom: 200.0),
              child: Text(
                'Total: \$${saleTotal.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
      floatingActionButton: nextPressed
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        confirm(context);
                      },
                      child: const Text('Confirmar compra'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: back,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 164, 58, 58),
                      ),
                      child: const Text('Volver'),
                    ),
                    const SizedBox(
                      width: 10,
                      height: 100,
                    ),
                  ],
                ),
                const SizedBox(width: 16),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: cancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(onPressed: next, child: const Text('Siguiente')),
                const SizedBox(height: 200),
              ],
            ),
    );
  }
}
