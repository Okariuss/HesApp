class ErrorMessage {
  final int? statusCode;
  final String? message;

  ErrorMessage(this.statusCode, this.message);

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(
      json['statusCode'] as int?,
      json['message'] as String?,
    );
  }

  @override
  String toString() {
    return 'ErrorMessage: { statusCode: $statusCode, message: $message }';
  }
}
