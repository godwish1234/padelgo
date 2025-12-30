import 'package:get_it/get_it.dart';
import 'package:padelgo/repository/interfaces/profile_repository.dart';
import 'package:padelgo/services/interfaces/profile_service.dart';

class ProfileServiceImpl implements ProfileService {
    final _profileRepository = GetIt.instance<ProfileRepository>();

  @override
  Future<dynamic> getUserProfile() {
    return _profileRepository.getUserProfile();
  }
}
