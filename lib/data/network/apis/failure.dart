
import 'package:dio/dio.dart';

class Failure implements Exception {
  Failure({required this.message});

  String message;
}

class AuthException extends Failure {
  AuthException({message})
      : super(message: message as String);
}

class ClientException extends Failure {
  ClientException({message}) : super(message: message as String);
}

class ServerException extends Failure {
  ServerException({message}) : super(message: message as String);
}

class UnknownException extends Failure {
  UnknownException({message}) : super(message: message as String);
}

class ErrorHandler {
  static String getErrorMessage(Response response) {
    if(response.data != null) {
      final data = response.data as Map;
      final message = data['message'] as String;
      if(message.isEmpty) {
        final error = data['error'] as String;
        return error;
      }else{
        return message;
      }
    }
    return '';
  }
}