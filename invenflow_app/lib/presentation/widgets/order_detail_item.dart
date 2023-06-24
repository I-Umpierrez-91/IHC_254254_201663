import 'package:flutter/material.dart';

import '../../models/order_detail.dart';

class OrderDetailItem extends StatelessWidget {
  final OrderDetail orderDetail;

  const OrderDetailItem({
    Key? key,
    required this.orderDetail,
  }) : super(key: key);

  Future<void> onRemove() async {
    // Lógica para eliminar el detalle de la venta
    // Puedes reemplazar esta implementación con la lógica adecuada a tu aplicación
    return Future.delayed(Duration(seconds: 1), () {
      print('Eliminando detalle de venta');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(orderDetail.product.name),
      subtitle: Text(
        'Cantidad: ${orderDetail.quantity} - Precio: \$${orderDetail.subtotal}',	),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => onRemove(),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}