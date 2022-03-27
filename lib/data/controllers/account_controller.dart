import 'dart:developer';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/data/controllers/state_controller.dart';
import 'package:imgur/data/services/shared_preferences.dart';

class AccountController extends StateController {
  UserModel get currentUser => _currentUser;
  UserModel _currentUser = UserModel(username: '');
  final SharedPreferenceService _preferenceService =
      locator<SharedPreferenceService>();
  final AmplifyService _amplifyService = AmplifyService();
  List<Albums> userAlbums = [];
  List<Albums> userFavouriteAlbums = [];
  List<PostComment> userComments = [];
  _getUserComments() async {
    _amplifyService.getUserCommentsStream().listen((event) {
      userComments = event.items;
      notifyListeners();
    });
  }

  _getUserAlbums() async {
    _amplifyService.getUserAlbumsStream().listen((event) {
      userAlbums = event.items.where((element) => element.isFavourite == false).toList();
      userFavouriteAlbums =
          event.items.where((element) => element.isFavourite == true).toList();
      log('userAlbums: $userAlbums userFavouriteAlbums: $userFavouriteAlbums');
      notifyListeners();
    });
  }

  String? acessToken;

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

  Future<bool> loadAccessTokenFromStorage() async {
    final token = await _preferenceService.readToken();
    if (token != null) {
      acessToken = token;
      return true;
    }
    return false;
  }

  getAccountInfo() {
    _getUserAlbums();
    _getUserComments();
    log('getAccount');
  }
}
