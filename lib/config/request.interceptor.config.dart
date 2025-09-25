import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http_request;
import 'package:umair_liaqat/config/app_configurations.dart';

class RequestInterceptor extends http_request.BaseClient {
  http_request.Client? _inner;

  RequestInterceptor() {
    _inner = http_request.Client();
  }

  @override
  Future<http_request.StreamedResponse> send(
    http_request.BaseRequest request,
  ) async {
    try {
      if (AppConfigurations.authToken.isNotEmpty) {
        request.headers['content-type'] = 'application/json';
        request.headers['Authorization'] =
            'Bearer ${AppConfigurations.authToken}';
      } else {
        request.headers['content-type'] = 'application/json';
      }
    } catch (e) {
      log("RequestInterceptor Send-:$e");
    }

    http_request.StreamedResponse? result;
    try {
      log(request.toString());
      result = await _inner!.send(request);
    } on SocketException catch (error) {
      throw http_request.ClientException(
        'Failed host lookup: ${error.message}',
        request.url,
      );
    } catch (error) {
      String message = "";
      if (error is String) {
        message = error;
      }
      if (message.isNotEmpty &&
          message.toLowerCase().contains("bad file descriptor")) {
        _inner = null;
        _inner = http_request.Client();
        result = await _inner!.send(request);
      }
    }
    return result!;
  }
}
