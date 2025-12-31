import 'package:padelgo/models/news_model.dart';
import 'package:padelgo/models/partner_model.dart';

abstract class IHomeService {
  Future<List<NewsModel>> getNews({int page = 1, int perPage = 15});
  Future<List<PartnerModel>> getPartners({int page = 1, int perPage = 10});
}
