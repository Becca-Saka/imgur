import 'dart:developer';

import 'package:imgur/data/services/api_base_helper.dart';
import 'package:imgur/data/services/api_response.dart';

ApiBaseHelper _helper = ApiBaseHelper();

class FeedRepository {
  Future<ApiResponse> getFeed() async {
    var url = '/gallery/top/{{sort}}/{{window}}/{{page}}';
    final response = await _helper.getData(url, hasHeader: true);
    return response;
  }

  Future<ApiResponse> getViralFeed() async {
    var url = '/gallery/hot/{{sort}}/{{window}}/{{page}}';
    final response = await _helper.getData(url, hasHeader: true);
    return response;
  }

  Future<ApiResponse> getUserSubFeed() async {
    var url = '/gallery/user/{{sort}}/{{window}}/{{page}}';
    final response = await _helper.getData(url, hasHeader: true);
    return response;
  }
   Future<ApiResponse> uploadImages() async {
    var url = '/gallery/user/{{sort}}/{{window}}/{{page}}';
    final response = await _helper.getData(url, hasHeader: true);
    return response;
  }

}
