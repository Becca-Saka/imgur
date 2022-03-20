import 'dart:developer';

import 'package:imgur/data/services/api_base_helper.dart';
import 'package:imgur/data/services/api_response.dart';

ApiBaseHelper _helper = ApiBaseHelper();

class UserRepository {
  Future<ApiResponse> getFeed() async {
    var url = '/gallery/top/{{sort}}/{{window}}/{{page}}';
    final response = await _helper.getData(url, hasHeader: true);
    return response;
  }

  // Future<ApiResponse> signUp(User user) async {
  //   var url = '/signup';
  //   final response = await _helper.postData(url, user.toSignUpJson());
  //   return response;
  // }

  // Future<ApiResponse> login(User user) async {
  //   var url = '/auth';
  //   final response = await _helper.postData(url, user.toLoginJson());
  //   return response;
  // }

  // Future<ApiResponse> resetPassword(String email) async {
  //   var url = '/reset_password';
  //   final response = await _helper.postData(url, {'email': email});

  //   return response;
  // }

  // Future<ApiResponse> createNewPassword(
  //     String email, int otp, String newPassword) async {
  //   var url = '/change_pass';
  //   final response = await _helper.postData(
  //     url,
  //     {
  //       'email': email,
  //       'otp': otp.toString(),
  //       'password': newPassword,
  //     },
  //   );
  //   return response;
  // }

  // Future<ApiResponse> changePassword(Map<String, dynamic> payload) async {
  //   var url = '/change_pass';
  //   final response = await _helper.postData(url, payload);
  //   return response;
  // }

  // Future<ApiResponse> updateProfile(
  //     String fullname, String phone, String address) async {
  //   var url = '/profile';
  //   final payload = {
  //     'fullname': fullname,
  //     'phone_number': phone,
  //     'address': address,
  //   };
  //   final response = await _helper.postData(url, payload);
  //   return response;
  // }

  // Future<ApiResponse> getProfileDetails() async {
  //   var url = '/profile';
  //   final response = await _helper.getData(url, hasHeader: true);
  //   log('message ${response.data}');
  //   return response;
  // }
}
