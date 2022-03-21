import 'package:get_it/get_it.dart';
import 'package:imgur/app/routes/navigator.dart';
import 'package:imgur/data/controllers/feed_controller.dart';
import 'package:imgur/data/repository/feed_repository.dart';
import 'package:imgur/data/services/authentication_service.dart';
import 'package:imgur/app/snackbar_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SnackBarService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FeedRepository());


  locator.registerLazySingleton(() => FeedController());
}