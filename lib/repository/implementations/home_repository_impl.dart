import 'package:padelgo/constants/end_point.dart';
import 'package:padelgo/models/news_model.dart';
import 'package:padelgo/models/partner_model.dart';
import 'package:padelgo/repository/base/rest_api_repository_base.dart';
import 'package:padelgo/repository/interfaces/home_repository.dart';

class HomeRepositoryImpl extends RestApiRepositoryBase
    implements IHomeRepository {
  @override
  Future<NewsListResponse> getNews({int page = 1, int perPage = 15}) async {
    final endpoint = '${EndPoint.news}?page=$page&per_page=$perPage';

    final responseData = await get(endpoint);

    return NewsListResponse.fromJson(responseData);
  }

  @override
  Future<PartnerListResponse> getPartners(
      {int page = 1, int perPage = 10}) async {
    final endpoint = '${EndPoint.partners}?page=$page&per_page=$perPage';

    final responseData = await get(endpoint);

    return PartnerListResponse.fromJson(responseData);
  }
}
