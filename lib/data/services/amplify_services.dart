import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:imgur/models/ModelProvider.dart';

class AmplifyService {
  final auth = Amplify.Auth;
  final dataStore = Amplify.DataStore;

  saveUserUpload(UserModel user, Albums album) async {
    await dataStore.save(user);
     await dataStore.save(album);
  }

  saveUserComments() {}
}
