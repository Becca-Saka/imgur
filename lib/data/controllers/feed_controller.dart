import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:imgur/app/appstate.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/data/controllers/account_controller.dart';
import 'package:imgur/data/repository/api_repository.dart';
import 'package:imgur/data/services/amplify_services.dart';
import 'package:imgur/data/services/api_response.dart';
import 'package:imgur/models/ModelProvider.dart';
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
  AmplifyService _amplifyService = AmplifyService();
  UserModel get currentUser => _accountController.currentUser;
  List<FeedModel> feeds = [];
  List<FeedModel> viralfeeds = [];
  List<FeedModel> userSubfeeds = [];
  List<FeedModel> followingfeeds = [];
  List<String> imagesToUpload = [];
  String? uploadTitle;
  String? albumId;

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
        final feedslist = response.data as List<dynamic>;
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
      imagesToUpload = [...imagesToUpload, ...res];
      notifyListeners();
    }
  }

  rearrangeFiles(int oldIndex, int newIndex) {
    // setState(() {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = imagesToUpload.removeAt(oldIndex);
    imagesToUpload.insert(newIndex, item);
    notifyListeners();
    // });
  }

  uploadFiles() async {
    log('uploading files');
    setAppState(AppState.busy);
    final rsp = await _apiRepository.createAlbum(uploadTitle);
    if (rsp.isSuccessful) {
      log('album created');
      final albumId = rsp.data['id'];
      final albumresp = await _apiRepository.getAlbum(albumId);
      log('album resp: ${albumresp.data}');
      final user = _accountController.currentUser;
      final albumData = albumresp.data;

      log('album id: $albumId');
      var cover;
      for (int i = 0; i < imagesToUpload.length; i++) {
        final byte = await File(imagesToUpload[i]).readAsBytes();
        String fileInBase64 = base64Encode(byte);
        log('uploading file');
        final response =
            await _apiRepository.uploadImages(albumId, fileInBase64);
        if (i == 0) {
          cover = response.data;
        }
        log('uploaded file ${response.message}');
        log('uploaded file ${response.data}');
        log('uploaded file ${response.code}');
        log('uploaded file ${response.isSuccessful}');
      }
      final Albums album = Albums(
        imgureId: '$albumId',
        usermodelID: user.id,
        imgurAlbumLink: albumData['link'],
        coverLink: cover['link'],
        coverType: cover['type'],
        title: albumData['title']??'',
        length: imagesToUpload.length,
        dateTime: albumData['datetime'],
      );
      log('album to datastor: ${album.toString()}');

      await _amplifyService.saveUserUpload(
          _accountController.currentUser, album);
      // this.albumId = albumId;
      setAppState(AppState.idle);
    }
  }

  navigateToUpload() async {
    final imageResult = await pickFile();
    if (imageResult != null) {
      imagesToUpload = imageResult;
      log('${imagesToUpload.length}');
      _navigationService.navigateTo(Routes.uploadView,
          arguments: imagesToUpload);
    }
  }

  navigateToRearrange() => _navigationService.navigateTo(Routes.rearrangeView);
}
