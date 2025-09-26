import 'dart:convert';

import 'package:umair_liaqat/config/app_configurations.dart';
import 'package:umair_liaqat/config/network.config.dart';
import 'package:umair_liaqat/models/user_model.dart';
import 'package:umair_liaqat/services/error_handler_service.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/collections.dart';

class UserRepository extends NetworkConfiguration {
  Future<bool> login(String email, String password) async {
    return await ErrorHandlerService.errorHandler(
      operation: () async {
        final body = {"email": email, "password": password};
        var response = await post(endpoint: ApiEndpoints.login, body: body);
        if (response.statusCode == 200) {
          final decodedResponse = jsonDecode(response.body);
          if (decodedResponse['token'] != null &&
              decodedResponse['token'].toString().isNotEmpty) {
            AppConfigurations.authToken = decodedResponse['token'];
            return true;
          } else {
            throw Exception(AppStrings.somethingWentWrong);
          }
        }
        return false;
      },
      functionName: "login",
    );
  }

  Future<UserModel?> getUser() async {
    return await ErrorHandlerService.errorHandler(
      operation: () async {
        var response = await get(
          endpoint: ApiEndpoints.getUser,
        );
        if (response.statusCode == 200) {
          // final decodedResponse = jsonDecode(response.body);
          final user = UserModel.fromJson(response.body);
          return user;
        }
        return null;
      },
      functionName: "getUser",
    );
  }
}
