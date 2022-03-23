import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:imgur/app/appstate.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/data/repository/api_repository.dart';
import 'package:imgur/data/services/api_response.dart';
import 'state_controller.dart';

class FeedController extends StateController {
  final NavigationService _navigationService = locator<NavigationService>();
  final ApiRepository _userRepository = locator<ApiRepository>();
  List<FeedModel> feeds = [];
  List<FeedModel> viralfeeds = [];
  List<FeedModel> userSubfeeds = [];
  List<FeedModel> followingfeeds = [];
  List<String> imagesToUpload = [];
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
  int currentIndex = 0;
  onTabChanged(int index) async {
    if (index == 1) {
      navigateToUpload();
    } else {
      currentIndex = index;
    }
  }

  Future<void> getViralFeeds() async {
    if (viralfeeds.isEmpty) {
      setAppState(AppState.busy);
      ApiResponse? response = await _userRepository.getViralFeed();
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
      ApiResponse? response = await _userRepository.getUserSubFeed();
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
