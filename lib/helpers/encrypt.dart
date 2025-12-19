import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';

Future<String> encryption(List<String> params) async {
  String jsonStr = jsonEncode(params);
  final key = encrypt.Key.fromUtf8("6d7fd6d862935c66");
  final iv = encrypt.IV.fromLength(16); // 16 bytes IV
  final encrypter =
      encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
  List<int> sha1Bytes = utf8.encode(jsonStr);
  var encrypted = encrypter.encryptBytes(sha1Bytes, iv: iv);
  final ivAndEncrypted = Uint8List.fromList(iv.bytes + encrypted.bytes);
  var base = base64Encode(ivAndEncrypted);
  return base;
}
