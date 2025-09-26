import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:umair_liaqat/config/network.config.dart';
import 'package:umair_liaqat/utils/app_strings.dart';

class ErrorHandlerService {
  static Future<dynamic> errorHandler({
    required Function() operation,
    Function? catchOperation,
    Function? finallyOperation,
    required String functionName,
    String? error,
    bool showSnackBar = false,
  }) async {
    try {
      return await operation();
    } on AuthException catch (e) {
      log("AuthException: Error in $functionName: ${e.message}");
      if (catchOperation != null) {
        catchOperation();
      }
      Fluttertoast.showToast(
          msg:
              "${AppStrings.failedToDoSomething(error ?? functionName)}: ${e.toString()}");
    } on ServerException catch (e) {
      log("ServerException: Error in $functionName: ${e.message}");
      if (catchOperation != null) {
        catchOperation();
      }
      Fluttertoast.showToast(
          msg:
              "${AppStrings.failedToDoSomething(error ?? functionName)}: ${e.toString()}");
    } on ClientException catch (e) {
      log("ClientException: Error in $functionName: ${e.message}");
      if (catchOperation != null) {
        catchOperation();
      }
      Fluttertoast.showToast(
          msg:
              "${AppStrings.failedToDoSomething(error ?? functionName)}: ${e.toString()}");
    } on NoInternetException catch (e) {
      log("NoInternetException: Error in $functionName: ${e.message}");
      if (catchOperation != null) {
        catchOperation();
      }
      Fluttertoast.showToast(
          msg:
              "${AppStrings.failedToDoSomething(error ?? functionName)}: ${e.toString()}");
    } catch (e) {
      log("Error in $functionName: $e");
      if (catchOperation != null) {
        catchOperation();
      }
      Fluttertoast.showToast(
          msg:
              "${AppStrings.failedToDoSomething(error ?? functionName)}: ${e.toString()}");
    } finally {
      if (finallyOperation != null) {
        finallyOperation();
      }
    }
  }
}
