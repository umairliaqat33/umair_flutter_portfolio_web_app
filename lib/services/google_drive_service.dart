import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:umair_liaqat/main.dart';

/// Upload a PlatformFile to Google Drive and get its public link
Future<String?> uploadPlatformFile(PlatformFile platformFile) async {
  try {
    final imageFile = File(platformFile.path!);
    String url = await uploadImage(imageFile);
    return url;
  } catch (e) {
    log('❌ Error uploading to Drive: $e');
    return null;
  }
}

Future<String> uploadImage(File image) async {
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
    app: storageFirebase,
    // bucket: "life-link-86ed1.appspot.com",
  );

  try {
    String fileName = image.path.split('/').last;
    Reference ref = storage.ref().child('files/$fileName');
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  } catch (e) {
    log(e.toString());

    rethrow;
  }
}
