import 'package:get_it/get_it.dart';
import 'package:padelgo/models/product_item.dart';
import 'package:padelgo/repository/interfaces/more_deals_repository.dart';
import 'package:padelgo/services/interfaces/more_deals_service.dart';

class MoreDealsServiceImpl implements MoreDealsService {
  final _moreDealsRepository = GetIt.instance<MoreDealsRepository>();

  @override
  Future<List<ProductItem>?> getProducts() async {
    return _moreDealsRepository.getProducts();
  }
}
