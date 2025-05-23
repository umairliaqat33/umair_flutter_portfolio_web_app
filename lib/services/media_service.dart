import 'dart:developer';
// import 'dart:io';

import 'package:file_picker/file_picker.dart';

class MediaService {
  static Future<PlatformFile?> selectFile(List<String> extensionsList) async {
    // Map<Permission, PermissionStatus> permissionStatus = await [
    //   Permission.photos,
    // ].request();

    // Object permissionStatus =
    //     await MediaService.handlePermissions(extensionsList);

    try {
      // log("inlancing_file_select: $permissionStatus ");
      // if (permissionStatus == PermissionStatus.granted) {

      // } else {
      //   ToastUtil.showToast(AppStrings.storagePermissionRequired);
      //   openAppSettings();
      // }
      PlatformFile platformFile;
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: extensionsList,
        allowMultiple: false,
      );
      if (result == null) return null;
      platformFile = result.files.first;
      return platformFile;
    } catch (e) {
      // if (permissionStatus == PermissionStatus.denied) {
      //   throw StoragePermissionDenied(
      //     AppStrings.storagePermissionDenied,
      //   );
      // } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      //   throw StoragePermissionDeniedPermanently(
      //     AppStrings.storagePermissionDeniedPermanently,
      //   );
      // } else {
      //   // throw UnknownException("${AppStrings.wentWrong} ${e.toString()}", "");
      // }
      log("Error while picking file: $e");
    }
    return null;
  }

  // static Future<Object> handlePermissions(List<String> extensionsList) async {
  //   String? androidVersion = await AppService.getAndroidVersion();

  //   Object permissionStatus;
  //   if (Platform.isIOS) {
  //     permissionStatus = await Permission.photos.request();
  //   } else {
  //     if (double.parse(androidVersion ?? "") > 11) {
  //       if (extensionsList == imageExtentions) {
  //         permissionStatus = await Permission.photos.request();
  //       } else {
  //         permissionStatus = await Permission.manageExternalStorage.request();
  //       }
  //     } else {
  //       permissionStatus = await Permission.storage.request();
  //     }
  //   }
  //   return permissionStatus;
  // }

  static Future<List<PlatformFile>?> selectMultipleFile(
      List<String> extensionsList) async {
    // Map<Permission, PermissionStatus> permissionStatus = await [
    //   Permission.photos,
    // ].request();

    // Object permissionStatus = await handlePermissions(extensionsList);

    try {
      // log("inlancing_file_select: $permissionStatus ");
      // if (permissionStatus == PermissionStatus.granted) {

      // } else {
      //   ToastUtil.showToast(AppStrings.storagePermissionRequired);
      //   openAppSettings();
      // }
      List<PlatformFile> platformFile;
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: extensionsList,
        allowMultiple: true,
      );
      if (result == null) return null;
      platformFile = result.files;
      return platformFile;
    } catch (e) {
      // if (permissionStatus == PermissionStatus.denied) {
      //   throw StoragePermissionDenied(
      //     AppStrings.storagePermissionDenied,
      //   );
      // } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      //   throw StoragePermissionDeniedPermanently(
      //     AppStrings.storagePermissionDeniedPermanently,
      //   );
      // } else {
      //   // throw UnknownException("${AppStrings.wentWrong} ${e.toString()}", "");
      // }
      log("Error while picking multiple file: $e");
    }
    return null;
  }

  // Future<List?> getFileMetadata(String url) async {
  //   try {
  //     Dio dio = Dio();

  //     Response response = await dio.head(url);

  //     String? contentDisposition =
  //         response.headers.value('content-disposition');
  //     String? fileName =
  //         _extractFileNameFromContentDisposition(contentDisposition);

  //     String? contentLength = response.headers.value('content-length');
  //     int? fileSize =
  //         contentLength != null ? int.tryParse(contentLength) : null;

  //     String? contentType = response.headers.value('content-type');
  //     String fileExtension = _getFileExtension(fileName, contentType);
  //     return [
  //       fileName ?? "",
  //       fileSize ?? 0,
  //       fileExtension,
  //     ];
  //   } catch (e) {
  //     log('Error: $e');
  //   }
  //   return [];
  // }

  // String? _extractFileNameFromContentDisposition(String? contentDisposition) {
  //   if (contentDisposition == null) return null;

  //   // Try extracting filename* (RFC 5987, UTF-8 encoded)
  //   final utf8Regex = RegExp(fileRFCNameRegExPattern);

  //   final utf8Match = utf8Regex.firstMatch(contentDisposition);
  //   if (utf8Match != null) {
  //     return Uri.decodeFull(utf8Match.group(1)!);
  //   }

  //   // Try extracting regular filename (basic format)
  //   final basicRegex = RegExp(fileRegularNameRegExPattern);
  //   final basicMatch = basicRegex.firstMatch(contentDisposition);
  //   if (basicMatch != null) {
  //     return basicMatch.group(1);
  //   }

  //   // Handle filenames without quotes (edge cases)
  //   final unquotedRegex = RegExp(fileWithoutQuotesNameRegExPattern);
  //   final unquotedMatch = unquotedRegex.firstMatch(contentDisposition);
  //   if (unquotedMatch != null) {
  //     return unquotedMatch.group(1)?.trim();
  //   }

  //   // If no filename found, return null
  //   return null;
  // }

  // String _getFileExtension(String? fileName, String? contentType) {
  //   if (fileName != null && fileName.contains('.')) {
  //     return '.${fileName.split('.').last}';
  //   }
  //   switch (contentType) {
  //     case 'application/pdf' ||
  //           'application/octet-stream' ||
  //           'text/html; charset=UTF-8':
  //       return '.pdf';
  //     case 'application/vnd.ms-excel':
  //     case 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet':
  //       return '.xls';
  //     case 'application/msword':
  //     case 'application/vnd.openxmlformats-officedocument.wordprocessingml.document':
  //       return '.doc';
  //     case 'application/zip':
  //       return '.zip';

  //     // Handle image cases
  //     case 'image/jpeg':
  //       return '.jpg';
  //     case 'image/png':
  //       return '.png';
  //     case 'image/gif':
  //       return '.gif';
  //     case 'image/bmp':
  //       return '.bmp';
  //     case 'image/webp':
  //       return '.webp';
  //     case 'image/svg+xml':
  //       return '.svg';

  //     default:
  //       return ''; // Unknown type, no extension
  //   }
  // }

  // static Future<void> saveFileToDownloads(
  //     String url, String fileName, String extention) async {
  //   try {
  //     String? androidVersion = await AppService.getAndroidVersion();
  //     Object permissionStatus;

  //     // Request storage permission
  //     if (double.parse(androidVersion ?? "") >= 12) {
  //       permissionStatus = await Permission.manageExternalStorage.request();
  //     } else {
  //       permissionStatus = await Permission.storage.request();
  //     }

  //     if (permissionStatus == PermissionStatus.granted) {
  //       // Get the downloads directory
  //       Directory? downloadsDir = Directory(
  //           '/storage/emulated/0/Download'); // Default downloads directory for Android

  //       if (!downloadsDir.existsSync()) {
  //         log("Downloads directory does not exist");
  //         return;
  //       }

  //       String savePath = '${downloadsDir.path}/$fileName$extention';

  //       // Download the file using Dio
  //       Dio dio = Dio();
  //       await dio.download(url, savePath);

  //       log('File saved to: $savePath');
  //     } else {
  //       log("Permission status: ${permissionStatus.toString()}");
  //     }
  //   } catch (e) {
  //     log('Error saving file: $e');
  //   }
  // }

  // static Future<void> saveTextToDownloads(String textContent) async {
  //   try {
  //     Object permissionStatus = await handlePermissions(pdfExtentions);

  //     if (permissionStatus == PermissionStatus.granted) {
  //       final tempDir = await getTemporaryDirectory();
  //       final tempFilePath = '${tempDir.path}/tempfile.doc';
  //       final tempFile = File(tempFilePath);
  //       await tempFile.writeAsString(textContent);

  //       late String downloadsPath;
  //       if (Platform.isAndroid) {
  //         final downloadsDir = Directory('/storage/emulated/0/Download');
  //         if (!downloadsDir.existsSync()) {
  //           log("Downloads directory does not exist");
  //           return;
  //         }
  //         downloadsPath = downloadsDir.path;
  //       } else if (Platform.isIOS) {
  //         final appDocumentsDir = await getApplicationDocumentsDirectory();
  //         downloadsPath = appDocumentsDir.path;
  //       }
  //       final downloadsFilePath = '$downloadsPath/srs.doc';
  //       await tempFile.copy(downloadsFilePath);

  //       log("File saved successfully at $downloadsFilePath");
  //     } else {
  //       log("Permission status not granted");
  //     }
  //   } catch (e) {
  //     log("Error saving file: $e");
  //   }
  // }
}
// client id  1076895934039-dv91vrhq6cen8oqrqkg9sp37hobj03i2.apps.googleusercontent.com
// client secret     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
