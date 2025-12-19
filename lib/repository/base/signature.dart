import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:encrypt/encrypt.dart' as Encrypt;

Future<String> sign(String encryptionStr, String token, String deviceUUID,
    String timestamp, String userToken) async {
  List<int> bytes = base64.decode(encryptionStr);
  Digest sha1Hash = sha1.convert(bytes);
  var sha1Str = sha1Hash.toString();
  String raw = token + userToken + deviceUUID + sha1Str + timestamp;
  return hashHmac("6d7fd6d862935c66", raw);
}

Future<String> encryption(List params, bool isZip) async {
  String jsonStr = jsonEncode(params);
  List<int> jsonBytes = utf8.encode(jsonStr);

  // Compress the byte array if `isZip` is true
  // if (isZip) {
  //   jsonBytes = const ZLibEncoder().encode(jsonBytes);
  // }

  // Encryption setup
  final key = Encrypt.Key.fromUtf8("6d7fd6d862935c66");
  final iv = Encrypt.IV.fromLength(16);
  final encrypter =
      Encrypt.Encrypter(Encrypt.AES(key, mode: Encrypt.AESMode.cbc));

  var encrypted = encrypter.encryptBytes(jsonBytes, iv: iv);

  final ivAndEncrypted = Uint8List.fromList(iv.bytes + encrypted.bytes);

  final base = base64Encode(ivAndEncrypted);
  return base;
}

String hashHmac(String key, String data) {
  try {
    final keyBytes = utf8.encode(key);
    final dataBytes = utf8.encode(data);
    final hmac = Hmac(sha1, keyBytes);
    final digest = hmac.convert(dataBytes);
    return digest.toString();
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return '';
  }
}

Future<String> generateEncodedString(String sessionUUID) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String appVersion = packageInfo.version;
  String appVersionCode = packageInfo.buildNumber;

  List<String> concatenatedString = [
    sessionUUID,
    appName,
    packageName,
    appVersion,
    appVersionCode
  ];

  String jsonString = jsonEncode(concatenatedString);
  String base64Encoded = base64.encode(utf8.encode(jsonString));

  String token = base64Encoded
      .replaceAll('+', '-')
      .replaceAll('/', '_')
      .replaceAll('=', '');

  return token;
}
