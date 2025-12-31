import 'package:padelgo/models/news_model.dart';
import 'package:padelgo/models/partner_model.dart';
import 'package:padelgo/repository/interfaces/home_repository.dart';
import 'package:padelgo/services/interfaces/home_service.dart';

class HomeServiceImpl implements IHomeService {
  final IHomeRepository _homeRepository;

  HomeServiceImpl(this._homeRepository);

  @override
  Future<List<NewsModel>> getNews({int page = 1, int perPage = 15}) async {
    final response =
        await _homeRepository.getNews(page: page, perPage: perPage);
    return response.data;
  }

  @override
  Future<List<PartnerModel>> getPartners(
      {int page = 1, int perPage = 10}) async {
    final response =
        await _homeRepository.getPartners(page: page, perPage: perPage);
    return response.data;
  }
}
