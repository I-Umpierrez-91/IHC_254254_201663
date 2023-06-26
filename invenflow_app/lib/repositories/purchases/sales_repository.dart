import 'package:invenflow_app/repositories/purchases/purchases_dataprovider.dart';

import '../../models/order_detail.dart';
import '../../models/purchase.dart';

import 'package:geolocator/geolocator.dart';

class PurchasesRepository {
  final PurchasesDataProvider _purchasesDataProvider;

  PurchasesRepository({required PurchasesDataProvider dataProvider})
      : _purchasesDataProvider = dataProvider;

  Future<int> createPurchase(List<OrderDetail> orderDetails) async {
    // GeoLocalization
    Position? position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final latitude = position.latitude;
    final longitude = position.longitude;

    Purchase? purchase = Purchase(
      provider: 1,
      latitude: latitude,
      longitude: longitude,
      orderDetails: orderDetails);
    try {
      return await _purchasesDataProvider.postSale(purchase);
    } catch (e) {
      print(e);
      return 500;
    } 
  }

}
