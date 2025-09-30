import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:umair_liaqat/config/network.config.dart';
import 'package:umair_liaqat/models/project_model.dart';
import 'package:umair_liaqat/services/error_handler_service.dart';
import 'package:umair_liaqat/utils/collections.dart';

class ProjectRepository extends NetworkConfiguration {
  Future<ProjectModel?> addProject(ProjectModel project) async {
    return await ErrorHandlerService.errorHandler(
      operation: () async {
        var response = await post(
            endpoint: ApiEndpoints.projectCrudRoute, body: project.toMap());

        if (response.statusCode == 201) {
          Fluttertoast.showToast(msg: "Project added");
          final json = jsonDecode(response.body);
          return ProjectModel.fromMap(json['project']);
        } else {
          return null;
        }
      },
      functionName: 'addProject',
      showToast: true,
    );
  }

  Future<void> updateProject(ProjectModel project) async {
    await ErrorHandlerService.errorHandler(
      operation: () async {
        await put(
          endpoint: "${ApiEndpoints.projectCrudRoute}${project.id}",
          body: project.toMap(),
        );
      },
      functionName: 'updateProject',
      showToast: true,
    );
  }

  Future<void> deleteProject(String projectId) async {
    await ErrorHandlerService.errorHandler(
      operation: () async {
        await delete(
          endpoint: "${ApiEndpoints.projectCrudRoute}$projectId",
        );
      },
      functionName: 'deleteProject',
      showToast: true,
    );
  }
}
