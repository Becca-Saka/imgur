import 'package:imgur/app/barrel.dart';
import 'package:imgur/data/controllers/state_controller.dart';
import 'package:imgur/data/repository/api_repository.dart';
import 'package:imgur/data/services/shared_preferences.dart';
import 'package:imgur/models/ModelProvider.dart';

class AccountController extends StateController {
  UserModel get currentUser => _currentUser;
  UserModel _currentUser = UserModel(username: '');
  final SharedPreferenceService _preferenceService =
      locator<SharedPreferenceService>();
  final ApiRepository _apiRepository = locator<ApiRepository>();

  updateCurrentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  updateAndSaveCurrentUser(UserModel user) async {
    _currentUser = user;
    notifyListeners();
    await _preferenceService.saveUser(user);
  }

  loadUserFromStorage() async {
    final user = await _preferenceService.readUser();
    if (user != null) {
      _currentUser = user;
    }
  }
}
