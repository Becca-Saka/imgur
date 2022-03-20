enum ApiStatus {
  success,
  failure,
}

class ApiResponse {
  final int? code;
  final dynamic data;
  dynamic others;
  final bool isSuccessful;
  final String? message;

  ApiResponse({
    this.code,
    this.message,
    this.others,
    this.data,
    required this.isSuccessful,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'],
      isSuccessful: json['success'],
      data: json['data'],
    );
  }
  factory ApiResponse.timout() {
    return ApiResponse(
      data: null,
      isSuccessful: false,
      message: 'Error occured. Please try again',
    );
  }
}
