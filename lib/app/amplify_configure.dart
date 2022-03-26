import 'dart:developer';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:imgur/amplifyconfiguration.dart';
import 'package:imgur/models/ModelProvider.dart';

class AmplifyConfiguration {
  AmplifyConfiguration._privateConstructor();

  static final AmplifyConfiguration instance = AmplifyConfiguration._privateConstructor();
  bool isSignedIn = false;
  bool isDataStoreInitialized = false;

  Future<void> init() async {
    // final AmplifyAPI _apiPlugin = AmplifyAPI();
    final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();
    // final AmplifyStorageS3 _storagePlugin = AmplifyStorageS3();
    final AmplifyDataStore _dataStorePlugin = AmplifyDataStore(
      modelProvider: ModelProvider.instance,
    );

    try {
      await Amplify.addPlugins([
        // _apiPlugin,
        _dataStorePlugin,
        _authPlugin,
        // _storagePlugin
      ]);
      await Amplify.configure(amplifyconfig);
      // await getCurrentUser();
    } catch (e) {
      log('Amplify already configured');
    }
  }

  ///Checks the current auth session if there is a user signed in it startes the datastore sync.
  ///If no user is signed in the local datastore data that may be existing on the device is cleared,
  /// and restarted to make sure user data is not shared between sessions;
  Future<void> getCurrentUser() async {
    final auth = Amplify.Auth;
    final datastore = Amplify.DataStore;
    final currentUserSession = await auth.fetchAuthSession();
    if (currentUserSession.isSignedIn) {
      isSignedIn = true;

      await datastore.start();
    } else {
      await datastore.clear();
      await datastore.start();
    }
  }
}
