import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http_request;
import 'package:umair_liaqat/config/app_configurations.dart';
import 'package:umair_liaqat/config/request.interceptor.config.dart';

class NetworkConfiguration {
  http_request.Client? _http;
  http_request.Client? get http => _http;

  NetworkConfiguration() {
    final customInterceptor = RequestInterceptor();
    _http = customInterceptor;
  }

  void dispose() {
    _http?.close();
  }

  Future<http_request.Response> get({required String endpoint}) async {
    try {
      Uri url = Uri.parse('${AppConfigurations.rootURL}$endpoint');
      log("get: Api- $url");

      final response = await _http!.get(url);
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<http_request.Response> post({
    required String endpoint,
    required dynamic body,
    bool isEncode = true,
    Map<String, String>? headers,
  }) async {
    try {
      Uri url = Uri.parse('${AppConfigurations.rootURL}$endpoint');

      var data = isEncode ? json.encode(body) : body;

      log("post: Api- $url");
      log("post: Api- Body: $data");

      final response = await _http!.post(url, body: data, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<http_request.Response> put({
    required String endpoint,
    required dynamic body,
    bool isEncode = true,
    Map<String, String>? headers,
  }) async {
    try {
      Uri url = Uri.parse('${AppConfigurations.rootURL}$endpoint');
      var data = isEncode ? json.encode(body) : body;

      log("put: Api- $url");
      log("put: Api- Body: $data");

      final response = await _http!.put(url, body: data, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<http_request.Response> patch({
    required String endpoint,
    dynamic body,
    bool isEncode = true,
    Map<String, String>? headers,
  }) async {
    try {
      Uri url = Uri.parse('${AppConfigurations.rootURL}$endpoint');
      var data = isEncode ? json.encode(body) : body;

      log("patch: Api- $url");
      log("patch: Api- Body: $data");

      final response = await _http!.patch(url, body: data, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<http_request.Response> delete({required String endpoint}) async {
    try {
      Uri url = Uri.parse('${AppConfigurations.rootURL}$endpoint');
      log("delete: Api- $url");

      final response = await _http!.delete(url);
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  http_request.Response _handleError(dynamic error) {
    if (error is SocketException) {
      throw NoInternetException(message: "No Internet");
    } else if (error is TimeoutException) {
      throw TimeoutException(message: 'Request timed out');
    } else if (error is FormatException) {
      throw const FormatException('Response format is incorrect');
    } else if (error is http_request.ClientException ||
        error is ClientException) {
      throw ClientException(message: error.message);
    } else if (error is ServerException) {
      throw ServerException(message: 'Internal server error');
    } else {
      throw error;
    }
  }

  // JSON response parser with exception handling
  http_request.Response _handleResponse(http_request.Response response) {
    String? contentType = response.headers['content-type'];

    if (contentType != null && contentType.contains('application/json')) {
      try {
        var jsonData = jsonDecode(response.body);

        if (response.statusCode == 200) {
          return response;
        } else if (jsonData['message'] != null) {
          if (response.statusCode == 401) {
            throw AuthException(message: jsonData['message']);
          } else {
            throw ClientException(message: jsonData['message']);
          }
        } else {
          throw ClientException(message: response.body);
        }
      } catch (e) {
        log("ResponseJson decode:$e");
        rethrow;
      }
    }
    return response;
  }
}

class NoInternetException implements Exception {
  final String message;
  NoInternetException({required this.message});
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException({required this.message});
}

class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class ClientException implements Exception {
  final String message;
  ClientException({required this.message});
}

class AuthException implements Exception {
  final String message;
  AuthException({required this.message});
}
