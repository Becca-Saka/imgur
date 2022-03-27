import 'dart:developer';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:imgur/models/ModelProvider.dart';

class AmplifyService {
  final auth = Amplify.Auth;
  final dataStore = Amplify.DataStore;

  saveUserUpload(UserModel user, Albums album) async {
    await dataStore.save(user);
    await dataStore.save(album);
  }

  saveUserComments(PostComment comments) async {
    await dataStore.save(comments);
  }

  Stream<QuerySnapshot<Albums>> getUserAlbumsStream() async* {
    final user = await auth.getCurrentUser();
    yield* dataStore.observeQuery(Albums.classType,
        where: Albums.USERMODELID.eq(user.userId));
  }

  Stream<QuerySnapshot<PostComment>> getUserCommentsStream() async* {
    final user = await auth.getCurrentUser();
    yield* dataStore.observeQuery(PostComment.classType,
        where: PostComment.USERMODELID.eq(user.userId));
  }

  saveUserFavorite(Albums album) async {
    log('favorite xx: ${album.toString()}');
    await dataStore.save(album);
  }
}
