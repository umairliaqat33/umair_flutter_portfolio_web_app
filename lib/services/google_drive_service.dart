import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:umair_liaqat/main.dart';

/// Upload a PlatformFile to Google Drive and get its public link
import 'dart:typed_data';

Future<String?> uploadPlatformFile(PlatformFile platformFile) async {
  try {
    final Uint8List? fileBytes = platformFile.bytes;
    final String fileName = platformFile.name;

    if (fileBytes == null) {
      log("❌ File bytes are null. Cannot upload.");
      return null;
    }

    final FirebaseStorage storage =
        FirebaseStorage.instanceFor(app: storageFirebase);
    final Reference ref = storage.ref().child('files/$fileName');

    final UploadTask uploadTask = ref.putData(fileBytes);
    final TaskSnapshot snapshot = await uploadTask;

    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    log('❌ Error uploading to Firebase Storage: $e');
    return null;
  }
}
