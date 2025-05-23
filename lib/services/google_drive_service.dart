import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;

/// Google Sign-In with Drive scope
final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId:
      '1076895934039-dv91vrhq6cen8oqrqkg9sp37hobj03i2.apps.googleusercontent.com',
  scopes: [drive.DriveApi.driveFileScope],
);

/// Auth Client for Google APIs
class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}

/// Upload a PlatformFile to Google Drive and get its public link
Future<String?> uploadPlatformFileToDrive(PlatformFile platformFile) async {
  try {
    final account =
        await _googleSignIn.signInSilently() ?? await _googleSignIn.signIn();
    if (account == null) return null;

    final authHeaders = await account.authHeaders;
    final driveApi = drive.DriveApi(GoogleAuthClient(authHeaders));

    final fileBytes = platformFile.bytes;
    if (fileBytes == null) return null;

    final media = drive.Media(Stream.value(fileBytes), fileBytes.length);
    final driveFile = drive.File()..name = platformFile.name;

    // Upload
    final uploadedFile =
        await driveApi.files.create(driveFile, uploadMedia: media);

    // Set permission to public
    final permission = drive.Permission()
      ..type = 'anyone'
      ..role = 'reader';
    await driveApi.permissions.create(permission, uploadedFile.id!);

    // Return shareable link
    return 'https://drive.google.com/file/d/${uploadedFile.id}';
  } catch (e) {
    log('❌ Error uploading to Drive: $e');
    return null;
  }
}
