import 'package:flutter/foundation.dart';
import 'package:padelgo/constants/end_point.dart';
import 'package:padelgo/models/product_item.dart';
import 'package:padelgo/repository/base/helpers.dart';
import 'package:padelgo/repository/base/rest_api_repository_base.dart';
import 'package:padelgo/repository/interfaces/more_deals_repository.dart';

class MoreDealsRepositoryImpl extends RestApiRepositoryBase
    implements MoreDealsRepository {
  @override
  Future<List<ProductItem>?> getProducts() async {
    try {
      return await GetHelper<ProductItem>().getListCommon(() async {
        return await get(EndPoint.cpiProducts);
      }, ProductItem.fromJson);
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to fetch products: $e');
      }
      rethrow;
    }
  }
}
