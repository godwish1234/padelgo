import 'package:padelgo/models/product_item.dart';

abstract class MoreDealsRepository {
  Future<List<ProductItem>?> getProducts();
}
