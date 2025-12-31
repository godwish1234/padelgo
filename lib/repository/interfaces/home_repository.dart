import 'package:padelgo/models/news_model.dart';
import 'package:padelgo/models/partner_model.dart';

abstract class IHomeRepository {
  Future<NewsListResponse> getNews({int page = 1, int perPage = 15});
  Future<PartnerListResponse> getPartners({int page = 1, int perPage = 10});
}
