import 'package:json_annotation/json_annotation.dart';
import 'package:padelgo/mixin/base_protocol_mixin.dart';
import 'package:padelgo/models/product_item.dart';

part 'products.g.dart';

@JsonSerializable(explicitToJson: true)
class Products with BaseProtocolMixin {
  List<ProductItem>? data;

  Products({this.data});

  factory Products.fromJson(Map<String, dynamic> json) {
    final products = _$ProductsFromJson(json);
    products.parseBaseProtocol(json);
    return products;
  }

  Map<String, dynamic> toJson() {
    final json = _$ProductsToJson(this);
    json.addAll(getBaseProtocolJson());
    return json;
  }
}
