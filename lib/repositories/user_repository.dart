import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  Future<UserModel?> getUserWithoutToken() async {
    return await ErrorHandlerService.errorHandler(
      operation: () async {
        var response = await get(
          endpoint: ApiEndpoints.getUserWithoutToken,
        );
        if (response.statusCode == 200) {
          final user = UserModel.fromJson(response.body);
          return user;
        }
        return null;
      },
      functionName: "getUser",
    );
  }

  Future<void> contactForm(
      {required String email,
      required String name,
      required String message,
      required BuildContext context}) async {
    await ErrorHandlerService.errorHandler(
      operation: () async {
        var response = await post(endpoint: ApiEndpoints.contactForm, body: {
          "Email": email,
          "Name": name,
          "Message": message,
          'Subject': "Flutter web portfolio.",
          'Timestamp': DateTime.now().toString(),
        });

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          if (json['ok']) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Your response has been recorded!"),
                backgroundColor: Colors.green,
              ),
            );
          }
        } else {
          log(response.body);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error submitting form"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      catchOperation: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error submitting form"),
            backgroundColor: Colors.red,
          ),
        );
      },
      functionName: "contactForm",
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

  Future<void> updateUser(UserModel user) async {
    await ErrorHandlerService.errorHandler(
      operation: () async {
        var response = await put(
          endpoint: "${ApiEndpoints.getUser}/${user.id ?? ""}",
          body: user.toMap(),
        );
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
            msg: AppStrings.valueUpdated(AppStrings.userDetails),
          );
        }
      },
      showToast: true,
      functionName: "updateUser",
    );
  }
}
