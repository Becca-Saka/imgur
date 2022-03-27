import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:imgur/app/appstate.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/models/comments_models.dart';
import 'package:imgur/models/feed_arguments.dart';
import 'state_controller.dart';

final allowedExtensions = [
  'jpg',
  'png',
  'gif',
  'jpeg',
  'webp',
  'WEBM',
  'MPG',
  'MP2',
  'MPEG',
  'MPE',
  'MPV',
  'OGG',
  'MP4',
  'M4P',
  'M4V',
  'AVI',
  'WMV',
  'MOV',
  'QT',
  'FLV',
  'SWF',
  'AVCHD'
];

class FeedController extends StateController {
  final NavigationService _navigationService = locator<NavigationService>();
  final ApiRepository _apiRepository = locator<ApiRepository>();
  final AccountController _accountController = locator<AccountController>();
  UserModel get user => _accountController.currentUser;
  final AmplifyService _amplifyService = AmplifyService();
  UserModel get currentUser => _accountController.currentUser;
  List<FeedModel> feeds = [];
  List<FeedModel> viralfeeds = [];
  List<FeedModel> userSubfeeds = [];
  List<FeedModel> followingfeeds = [];
  List<CommentsModel> comments = [];
  List<Map<String, dynamic>> imagesToUploadMap = [];
  String? uploadTitle;
  FeedModel? uploadedFeed;

  TextEditingController commentController = TextEditingController();

  int currentIndex = 0;
  onTabChanged(int index) async {
    if (index == 1) {
      navigateToUpload();
    } else {
      currentIndex = index;
      notifyListeners();
    }
  }

  Future<void> getViralFeeds() async {
    if (viralfeeds.isEmpty) {
      setAppState(AppState.busy);
      ApiResponse? response = await _apiRepository.getViralFeed();
      if (response.isSuccessful) {
        var feedslist = response.data as List<dynamic>;
        feedslist = feedslist.where((e) => e['is_album'] == true).toList();
        viralfeeds = feedslist.map((e) => FeedModel.fromJson(e)).toList();
      }
      setAppState(AppState.idle);
    }
  }

  getUSerSubFeeds() async {
    if (viralfeeds.isEmpty) {
      setAppState(AppState.busy);
      ApiResponse? response = await _apiRepository.getUserSubFeed();
      if (response.isSuccessful) {
        final feedslist = response.data as List<dynamic>;
        userSubfeeds = feedslist.map((e) => FeedModel.fromJson(e)).toList();
      }
      setAppState(AppState.idle);
    }
  }

  void handleTabChange(index) {
    switch (index) {
      case 0:
        getViralFeeds();
        break;
      case 1:
        getUSerSubFeeds();
        break;
      case 2:
        //TODO: get following feeds
        break;
      case 3:
        //TODO: get snacks
        break;
      case 4:
        //TODO: get storytimes
        break;
    }
  }

  Future<List<String>?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: allowedExtensions);

    if (result != null) {
      return result.files.map((e) => e.path!).toList();
    }
    return null;
  }

  pickMoreFiles() async {
    final res = await pickFile();
    if (res != null) {
      for (var e in res) {
        imagesToUploadMap = [
          ...imagesToUploadMap,
          {'image': e, 'controller': TextEditingController()}
        ];
      }
      notifyListeners();
    }
  }

  rearrangeFiles(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = imagesToUploadMap.removeAt(oldIndex);
    imagesToUploadMap.insert(newIndex, item);
    notifyListeners();
  }

  uploadFiles() async {
    setAppState(AppState.busy);
    final rsp = await _apiRepository.createAlbum(uploadTitle);
    if (rsp.isSuccessful) {
      final albumId = rsp.data['id'];
      for (int i = 0; i < imagesToUploadMap.length; i++) {
        final image = imagesToUploadMap[i];
        final imagePath = image['image'];

        final imageDesc = image['controller'].text;
        final byte = await File(imagePath).readAsBytes();
        String fileInBase64 = base64Encode(byte);
        await _apiRepository.uploadImages(albumId, fileInBase64, imageDesc);
      }

      final albumresp = await _apiRepository.getAlbum(albumId);
      final album = await convertFeedToAlbum(albumresp.data);

      await _amplifyService.saveUserUpload(
          _accountController.currentUser, album);
      uploadedFeed = FeedModel.fromJson(albumresp.data);
      setAppState(AppState.idle);
    }
  }

  Future<Albums> convertFeedToAlbum(dynamic albumData) async {
    final cover = albumData['images']
        .firstWhere((element) => element['id'] == albumData['cover']);

    final Albums album = Albums(
      imgureId: albumData['id'],
      usermodelID: user.id,
      imgurAlbumLink: albumData['link'],
      coverLink: cover['link'],
      coverType: cover['type'],
      title: albumData['title'] ?? '',
      length: imagesToUploadMap.length,
      dateTime: albumData['datetime'],
      isFavourite: false,
      points: albumData['points'],
    );
    return album;
  }

  clear() {
    uploadedFeed = null;
    imagesToUploadMap = [];
    uploadTitle = null;
  }

  viewUploadedFeed() {
    _navigationService.closeAndNavigateTo(
      Routes.singleFeedItem,
      arguments: FeedArgumnet(feed: uploadedFeed!, isUserFeed: true),
    );
    clear();
  }

  getComments(String id) async {
    final response = await _apiRepository.getFeedComment(id);
    if (response.isSuccessful) {
      final comment = response.data as List<dynamic>;
      comments = comment.map((e) => CommentsModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

  makeComment(FeedModel feedModel) async {
    log('commenting');
    if (commentController.text.isNotEmpty) {
      final commentText = commentController.text;
      final response =
          await _apiRepository.postFeedComment(feedModel.id, commentController.text);
      if (response.isSuccessful) {
        log('data ${response.data}');
        final Album? album =
            feedModel.images != null && feedModel.images!.isNotEmpty
                ? feedModel.images!
                    .firstWhere((element) => element.id == feedModel.cover)
                : null;
        final String link = album != null ? album.link! : feedModel.link!;
        final type = album != null ? album.type! : feedModel.type!;
        final comments = PostComment(
            imgurId: '${response.data['id']}',
            usermodelID: user.id,
            coverType: type,
            coverLink: link,
            points: feedModel.points.toString(),
            date: DateTime.now().millisecondsSinceEpoch.toString(),
            comment: commentText);
        await _amplifyService.saveUserComments(comments);
        commentController.clear();
        _navigationService.back();
        log('comment posted');
      }
    }
  }

  favoriteImage(String id) async {
    final response = await _apiRepository.favoriteImage(id);
    if (response.isSuccessful) {
      final albumresp = await _apiRepository.getAlbum(id);
      Albums album = await convertFeedToAlbum(albumresp.data);
      final favorite = album.copyWith(
        isFavourite: true,
      );
      await _amplifyService.saveUserFavorite(favorite);
    }
  }

  navigateToUpload() async {
    final imageResult = await pickFile();
    if (imageResult != null) {
      for (var e in imageResult) {
        imagesToUploadMap = [
          ...imagesToUploadMap,
          {'image': e, 'controller': TextEditingController()}
        ];
      }
      _navigationService.navigateTo(Routes.uploadView);
    }
  }

  navigateToRearrange() => _navigationService.navigateTo(Routes.rearrangeView);
  void navigateToComment(FeedModel feedModel) =>
      _navigationService.navigateTo(Routes.commetsView, arguments: feedModel);
}
