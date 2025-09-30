import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:umair_liaqat/config/network.config.dart';
import 'package:umair_liaqat/models/job_history.dart';
import 'package:umair_liaqat/services/error_handler_service.dart';
import 'package:umair_liaqat/utils/collections.dart';

class JobHistoryRepository extends NetworkConfiguration {
  Future<JobHistory?> addJobHistory(JobHistory job) async {
    return await ErrorHandlerService.errorHandler(
      operation: () async {
        var response = await post(
            endpoint: ApiEndpoints.jobHistoryCrudRoute, body: job.toMap());

        if (response.statusCode == 201) {
          Fluttertoast.showToast(msg: "Job added");
          final json = jsonDecode(response.body);
          return JobHistory.fromMap(json['jobHistory']);
        } else {
          return null;
        }
      },
      functionName: 'addJobHistory',
      showToast: true,
    );
  }

  Future<void> updateJobHistory(JobHistory job) async {
    await ErrorHandlerService.errorHandler(
      operation: () async {
        await put(
          endpoint: "${ApiEndpoints.jobHistoryCrudRoute}${job.id}",
          body: job.toMap(),
        );
      },
      functionName: 'updateJobHistory',
      showToast: true,
    );
  }

  Future<void> deleteJobHistory(String jobId) async {
    await ErrorHandlerService.errorHandler(
      operation: () async {
        await delete(
          endpoint: "${ApiEndpoints.jobHistoryCrudRoute}$jobId",
        );
      },
      functionName: 'deleteJobHistory',
      showToast: true,
    );
  }
}
