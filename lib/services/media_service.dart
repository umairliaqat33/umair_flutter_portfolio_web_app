import 'dart:developer';
// import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:umair_liaqat/utils/collections.dart';

class MediaService {
  static Future<PlatformFile?> selectFile(List<String> extensionsList) async {
    try {
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
      log("Error while picking file: $e");
    }
    return null;
  }

  static Future<List<PlatformFile>?> selectMultipleFile(
      List<String> extensionsList) async {
    try {
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
      log("Error while picking multiple file: $e");
    }
    return null;
  }

  static Future<String?> uploadPlatformFile(
    PlatformFile file, {
    bool isForProfile = false,
  }) async {
    try {
      final filePath =
          "${isForProfile ? "profile" : "projects"}/${DateTime.now().millisecondsSinceEpoch}_${file.name}";

      final bytes = file.bytes;

      // final res =
      if (bytes != null) {
        final uValue = await Supabase.instance.client.storage
            .from(Collections.storageBucketId)
            .uploadBinary(
              filePath,
              bytes,
              fileOptions: FileOptions(
                upsert: true,
              ),
            );
        uValue;
      }

      final publicUrl = Supabase.instance.client.storage
          .from(Collections.storageBucketId)
          .getPublicUrl(filePath);

      return publicUrl;
    } catch (e) {
      log("Error uploading file: $e");
      return null;
    }
  }
}
