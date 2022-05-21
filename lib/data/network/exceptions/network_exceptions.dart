class NetworkException implements Exception {
  NetworkException({this.message, this.statusCode});

  String? message;
  int? statusCode;
}

class AuthException extends NetworkException {
  AuthException({message, statusCode})
      : super(message: message as String?, statusCode: statusCode as int?);
}
