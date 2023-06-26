import 'package:invenflow_app/repositories/sales/sales_dataprovider.dart';

import '../../models/order_detail.dart';
import '../../models/sale.dart';

import 'package:geolocator/geolocator.dart';

class SalesRepository {
  final SalesDataProvider _salesDataProvider;

  SalesRepository({required SalesDataProvider dataProvider})
      : _salesDataProvider = dataProvider;

  Future<int> createSale(List<OrderDetail> orderDetails) async {
    // GeoLocalization
    Position? position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final latitude = position.latitude;
    final longitude = position.longitude;

    Sale? sale = Sale(
      client: 1,
      saleDate: DateTime.now(),
      latitude: latitude,
      longitude: longitude,
      orderDetails: orderDetails);
    try {
      return await _salesDataProvider.postSale(sale);
    } catch (e) {
      print(e);
      return 500;
    } 
  }

}
