import 'package:flutter/material.dart';

import '../factory_service.dart';
import '../models/order_line.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  late List<OrderDetail> orderDetails = [];
  bool nextPressed = false;
  double saleTotal = 0.0;

  void addProduct() {
    setState(() {
      orderDetails.add(OrderDetail(
        productId: 1,
        price: 10,
        quantity: 1,
      ));
    });
  }

  void next() {
    setState(() {
      nextPressed = true;
      saleTotal = calculateSaleTotal();
    });
  }

  void cancel() {
    Navigator.pop(context); 
  }

  double calculateSaleTotal() {
    // Lógica para calcular el total de la venta
    // Puedes reemplazar esta implementación con la lógica adecuada a tu aplicación
    double total = 0.0;
    for (OrderDetail orderDetail in orderDetails) {
      // Supongamos que cada producto tiene un precio de $10
      total += 10.0;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventas'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orderDetails.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(orderDetails[index].productId.toString()),
                );
              },
            ),
          ),
          if (!nextPressed)
            FloatingActionButton(
              onPressed: addProduct,
              child: const Icon(Icons.add),
            ),
          const SizedBox(height: 16),
          if (nextPressed)
            Text(
              'Total: \$${saleTotal.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
        ],
      ),
      floatingActionButton: nextPressed
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Botón 1'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Botón 2'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Botón 3'),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: next,
                  child: const Text('Siguiente'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: cancel,
                  child: const Text('Cancelar'),
                ),
              ],
            ),
    );
  }
}
