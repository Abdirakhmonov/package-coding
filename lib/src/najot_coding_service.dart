import 'dart:convert';
import 'package:pointycastle/export.dart';
import 'dart:typed_data';

class NajotCodingService {
  final KeyParameter keyParam;
  final PaddedBlockCipher cipher;

  NajotCodingService(String keyString)
      : keyParam = KeyParameter(Uint8List.fromList(utf8.encode(keyString))),
        cipher = PaddedBlockCipher('AES/CBC/PKCS7') {
    final iv = Uint8List(16); // Initialization vector
    final params = PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
        ParametersWithIV<KeyParameter>(keyParam, iv), null);
    cipher.init(true, params);
  }

  String encrypt(String plainText) {
    final input = Uint8List.fromList(utf8.encode(plainText));
    final encrypted = cipher.process(input);
    return base64Encode(encrypted);
  }

  String decrypt(String encryptedText) {
    final iv = Uint8List(16); // Initialization vector
    final params = PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
        ParametersWithIV<KeyParameter>(keyParam, iv), null);
    cipher.init(false, params);
    final encrypted = base64Decode(encryptedText);
    final decrypted = cipher.process(encrypted);
    return utf8.decode(decrypted);
  }
}
