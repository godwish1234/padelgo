import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;

class Encryptor {
  static final encKey = utf8.encode("y9B10sT86AFErJcY");
  static final keyBytes = utf8.encode("06UCxOlmEX0UsoO786xBOMu8O9KYwwwR");
  static final ivBytes = utf8.encode("ULnzfWMd0bja5sQH");

  static final key = encrypt.Key(keyBytes);
  static final iv = encrypt.IV(ivBytes);

  static Future<String> encryptAES(final String originHex) async {
    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(originHex, iv: iv);
    return encrypted.base64;
  }

  static Future<String> decryptAES(final String originHex) async {
    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypt.Encrypted.fromBase64(originHex);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
}
