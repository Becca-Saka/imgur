import 'package:get_it/get_it.dart';
import 'package:imgur/app/routes/navigator.dart';
import 'package:imgur/data/controllers/account_controller.dart';
import 'package:imgur/data/controllers/authentication_controller.dart';
import 'package:imgur/data/controllers/feed_controller.dart';
import 'package:imgur/data/repository/api_repository.dart';
import 'package:imgur/data/services/authentication_service.dart';
import 'package:imgur/app/snackbar_service.dart';
import 'package:imgur/data/services/shared_preferences.dart';

GetIt locator = GetIt.instance;
///Used to inject service so we can acess anywhere
void setupLocator() {
  locator.registerLazySingleton(() => SharedPreferenceService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SnackBarService());
  locator.registerLazySingleton(() => ApiRepository());
  locator.registerLazySingleton(() => AccountController());
  locator.registerLazySingleton(() => FeedController(),);
  locator.registerLazySingleton(() => AuthenticationController());
}