import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:imgur/data/services/api_base_helper.dart';
import 'package:imgur/data/services/api_response.dart';

ApiBaseHelper _helper = ApiBaseHelper();

class ApiRepository {
  Future<ApiResponse> getAcessToken(body) async {
    var url = '/gallery/top';
    final response = await _helper.postData(url, body, hasHeader: true);
    return response;
  }

  Future<ApiResponse> getFeed() async {
    var url = '/gallery/top';
    final response = await _helper.getData(url, hasHeader: true);
    return response;
  }

  Future<ApiResponse> getViralFeed() async {
    var url = '/gallery/hot';
    final response = await _helper.getData(url, hasHeader: true);
    return response;
  }

  Future<ApiResponse> getUserSubFeed() async {
    var url = '/gallery/user';
    final response = await _helper.getData(url, hasHeader: true);
    return response;
  }

  Future<ApiResponse> getFeedComment(String id) async {
    var url = '/gallery/$id/comments';

    final response = await _helper.getData(url, hasHeader: true);
    return response;
  }

  Future<ApiResponse> postFeedComment(String id, String comment) async {
    var url = '/comment';
    final body = {'image_id': id, 'comment': comment};
    final response = await _helper.postData(url, body, hasTokenHeader: true);
    return response;
  }

  Future<ApiResponse> uploadImages(
      String id, String image, String? desc) async {
    var url = '/image';
    final body = {
      'image': image,
      'album': id,
      'type': 'base64',
    };
    if (desc != null && desc.isNotEmpty) {
      body['description'] = desc;
    }
    final response = await _helper.postData(url, body, hasTokenHeader: true);
    return response;
  }

  Future<ApiResponse> uploadVideos(String id, ByteData image) async {
    var url = '/upload';
    final body = {'image': image, 'album': id};
    final response = await _helper.postData(url, body, hasTokenHeader: true);
    return response;
  }

  Future<ApiResponse> createAlbum(String? title) async {
    var url = '/album';
    Map<String, String>? body;
    if (title != null) {
      body = {
        'title': title,
      };
    }
    final response = await _helper.postData(url, body, hasTokenHeader: true);
    return response;
  }

  Future<ApiResponse> getAlbum(String id) async {
    var url = '/album/$id';

    final response = await _helper.getData(url, hasHeader: true);
    return response;
  }

  Future<ApiResponse> favoriteImage(String? id) async {
    var url = '/album/$id/favorite';

    final response = await _helper.postData(url, null, hasTokenHeader: true);
    return response;
  }
}
