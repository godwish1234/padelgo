import 'package:get_it/get_it.dart';
import 'package:padelgo/services/implementations/authentication_service_impl.dart';
import 'package:padelgo/services/implementations/booking_service_impl.dart';
import 'package:padelgo/services/implementations/location_service_impl.dart';
import 'package:padelgo/services/implementations/navigation_service_impl.dart';
import 'package:padelgo/services/implementations/notification_service_impl.dart';
import 'package:padelgo/services/implementations/startup_service_impl.dart';
import 'package:padelgo/services/interfaces/authentication_service.dart';
import 'package:padelgo/services/interfaces/booking_service.dart';
import 'package:padelgo/services/interfaces/location_service.dart';
import 'package:padelgo/services/interfaces/navigation_service.dart';
import 'package:padelgo/services/interfaces/notification_service.dart';
import 'package:padelgo/services/interfaces/startup_service.dart';
import 'package:padelgo/initialization/services/navigation_service.dart'
    as old_nav;
import 'package:padelgo/providers/interfaces/internet_connectivity_provider.dart';
import 'package:padelgo/providers/implementations/internet_connectivity_provider_impl.dart';
import 'package:padelgo/repository/base/rest_api_repository_base.dart';

final GetIt serviceLocator = GetIt.instance;

Future setupServiceLocator() async {
  // Register Authentication Service
  serviceLocator.registerLazySingleton<AuthenticationService>(
    () => AuthenticationServiceImpl(),
  );

  // Register Location Service
  serviceLocator.registerLazySingleton<LocationService>(
    () => LocationServiceImpl(),
  );

  // Register Startup Service
  serviceLocator.registerLazySingleton<StartupService>(
    () => StartupServiceImpl(),
  );

  // Register Notification Service
  serviceLocator.registerLazySingleton<NotificationService>(
    () => NotificationServiceImpl(),
  );

  // Register Internet Connectivity Provider
  serviceLocator.registerLazySingleton<InternetConnectivityProvider>(
    () => InternetConnectivityProviderImpl(),
  );

  // Register Event Provider
  serviceLocator.registerLazySingleton<EventProvider>(
    () => EventProvider(),
  );

  // Register Navigation Services
  serviceLocator.registerSingleton<NavigationService>(NavigationServiceImpl());
  serviceLocator.registerLazySingleton<old_nav.NavigationService>(
    () => old_nav.NavigationService(),
  );

  // Register Booking Service
  serviceLocator.registerSingleton<BookingService>(BookingServiceImpl());
}
