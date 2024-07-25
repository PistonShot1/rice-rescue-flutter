class ResponseData {
  final String message;
  final int status;

  ResponseData({required this.message, required this.status});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(message: json['message'], status: json['status']);
  }
}
