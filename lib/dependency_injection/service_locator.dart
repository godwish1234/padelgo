import 'package:get_it/get_it.dart';
import 'package:padelgo/services/implementations/authentication_service_impl.dart';
import 'package:padelgo/services/implementations/booking_service_impl.dart';
import 'package:padelgo/services/implementations/profile_service_impl.dart';
import 'package:padelgo/services/interfaces/authentication_service.dart';
import 'package:padelgo/services/interfaces/booking_service.dart';
import 'package:padelgo/services/interfaces/profile_service.dart';
import 'package:padelgo/providers/interfaces/internet_connectivity_provider.dart';
import 'package:padelgo/providers/implementations/internet_connectivity_provider_impl.dart';
import 'package:padelgo/repository/base/rest_api_repository_base.dart';
import 'package:padelgo/repository/interfaces/authentication_repository.dart';
import 'package:padelgo/repository/implementations/authentication_repository_impl.dart';
import 'package:padelgo/repository/interfaces/profile_repository.dart';
import 'package:padelgo/repository/implementations/profile_repository_impl.dart';

final GetIt serviceLocator = GetIt.instance;

Future setupServiceLocator() async {
  // Register Authentication Repository
  serviceLocator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(),
  );

  // Register Authentication Service
  serviceLocator.registerLazySingleton<AuthenticationService>(
    () => AuthenticationServiceImpl(),
  );

  // Register Profile Repository
  serviceLocator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(),
  );

  // Register Profile Service
  serviceLocator.registerLazySingleton<ProfileService>(
    () => ProfileServiceImpl(),
  );

  // Register Internet Connectivity Provider
  serviceLocator.registerLazySingleton<InternetConnectivityProvider>(
    () => InternetConnectivityProviderImpl(),
  );

  // Register Event Provider
  serviceLocator.registerLazySingleton<EventProvider>(
    () => EventProvider(),
  );

  // Register Booking Service
  serviceLocator.registerSingleton<BookingService>(BookingServiceImpl());
}
