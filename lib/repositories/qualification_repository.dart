import 'package:fluttertoast/fluttertoast.dart';
import 'package:umair_liaqat/config/network.config.dart';
import 'package:umair_liaqat/models/qualification_model.dart';
import 'package:umair_liaqat/services/error_handler_service.dart';
import 'package:umair_liaqat/utils/collections.dart';

class QualificationRepository extends NetworkConfiguration {
  Future<void> addQualification(QualificationModel qualification) async {
    await ErrorHandlerService.errorHandler(
      operation: () async {
        var response = await post(
            endpoint: ApiEndpoints.qualificationCrudRoute,
            body: qualification.toMap());

        if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: "Qualification added");
        }
      },
      functionName: 'addQualification',
      showToast: true,
    );
  }

  Future<void> updateQualification(QualificationModel qualification) async {
    await ErrorHandlerService.errorHandler(
      operation: () async {
        await put(
          endpoint: "${ApiEndpoints.qualificationCrudRoute}${qualification.id}",
          body: qualification.toMap(),
        );
      },
      functionName: 'updateQualification',
      showToast: true,
    );
  }

  Future<void> deleteQualification(String qualificationId) async {
    await ErrorHandlerService.errorHandler(
      operation: () async {
        await delete(
          endpoint: "${ApiEndpoints.qualificationCrudRoute}$qualificationId",
        );
      },
      functionName: 'deleteQualification',
      showToast: true,
    );
  }
}
