import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:async';


import 'package:http/http.dart';

import 'api_response.dart';

class ApiBaseHelper {
  static const String _baseUrl = 'https://api.imgur.com/3/';

  // static const String apiKey = '1wvZmlIdydbubDWLTJuk';
  static const String clientID = '67d8be663102607';

  Map<String, String> headers = {'Authorization': 'Client-ID $clientID'};

  Future<ApiResponse> postData(String url, body,
      {bool hasHeader = false}) async {
    try {
      var request = MultipartRequest(
        'POST',
        Uri.parse(_baseUrl + url),
      );

      return await _sendRequest(
        request,
        hasHeader,
        body: body,
      );
    } on SocketException {
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: 'No Internet connection',
      );
    } on TimeoutException {
      return ApiResponse.timout();
    }
  }

  Future<ApiResponse> _sendRequest(request, bool hasHeader,
      {Map<String, String>? body}) async {
    if (body != null) {
      request.fields.addAll(body);
    }
    if (hasHeader) {
      headers['Authorization'] = 'Client-ID $clientID';
    }
    request.headers.addAll(headers);
    StreamedResponse response = await request.send().timeout(
          const Duration(seconds: 15),
        );
//         final g = await response.stream.bytesToString();
//  log('response fron '+g);
    return await _response(response);
  }

  Future<ApiResponse> getData(String url, {bool hasHeader = false}) async {
    try {
      var request = Request(
        'GET',
        Uri.parse(_baseUrl + url),
      );

      return await _sendRequest(request, hasHeader);
    } on SocketException {
      return ApiResponse(
        data: null,
        isSuccessful: false,
        message: 'No Internet connection',
      );
    } on TimeoutException {
      return ApiResponse.timout();
    }
  }
}

Future<ApiResponse> _response(StreamedResponse response) async {
  if (response.statusCode == 200) {
    return ApiResponse.fromJson(
        json.decode(await response.stream.bytesToString()));
  } else if (response.statusCode >= 400 && response.statusCode <= 499) {
    return ApiResponse(
      isSuccessful: false,
      message: json.decode(await response.stream.bytesToString())['data']['error'],
    );
  } else if (response.statusCode >= 500 && response.statusCode <= 599) {
    return ApiResponse(
      isSuccessful: false,
      message:
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
    );
  } else {
    return ApiResponse(
      isSuccessful: false,
      message: 'Error occured : ${response.statusCode}',
    );
  }
}

abstract class AppRepo {
  final ApiBaseHelper helper = ApiBaseHelper();
}
