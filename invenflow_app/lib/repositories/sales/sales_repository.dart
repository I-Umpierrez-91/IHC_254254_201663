import 'package:invenflow_app/repositories/sales/sales_dataprovider.dart';

import '../../models/order_detail.dart';
import '../../models/sale.dart';

class SalesRepository {
  final SalesDataProvider _salesDataProvider;

  SalesRepository({required SalesDataProvider dataProvider})
      : _salesDataProvider = dataProvider;

  Future createSale(List<OrderDetail> orderDetails) async {
    Sale? sale = Sale(
      client: 1,
      saleDate: DateTime.now(),
      orderDetails: orderDetails);
    try {
      return await _salesDataProvider.postSale(sale);
    } catch (e) {
      print(e);
    } 
  }

}
