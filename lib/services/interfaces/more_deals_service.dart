import 'package:padelgo/models/product_item.dart';

abstract class MoreDealsService<T> {
  Future<List<ProductItem>?> getProducts();
}
