import 'dart:convert';
import 'package:pointycastle/export.dart';
import 'dart:typed_data';

class NajotCodingService {
  final KeyParameter keyParam;
  final PaddedBlockCipher cipher;

  // Constructor initializes the KeyParameter and PaddedBlockCipher
  NajotCodingService(String keyString)
      : keyParam = KeyParameter(
          Uint8List.fromList(
            utf8.encode(
              keyString.padRight(32,
                  ' '), // Ensure the key is 32 bytes long by padding with spaces
            ),
          ),
        ),
        cipher = PaddedBlockCipher('AES/CBC/PKCS7') {
    final iv = Uint8List(
        16); // Initialization vector for AES (should be unique for each encryption)
    final params =
        PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
            ParametersWithIV<KeyParameter>(keyParam, iv), null);
    cipher.init(true, params); // Initialize cipher for encryption
  }

  // Encrypts the plain text using AES
  String encrypt(String plainText) {
    final input = Uint8List.fromList(
        utf8.encode(plainText)); // Convert plain text to bytes
    final encrypted = cipher.process(input); // Encrypt the bytes
    return base64Encode(encrypted); // Encode encrypted bytes as base64
  }

  // Decrypts the encrypted text using AES
  String decrypt(String encryptedText) {
    final iv = Uint8List(
        16); // Initialization vector for AES (should match the one used during encryption)
    final params =
        PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
            ParametersWithIV<KeyParameter>(keyParam, iv), null);
    cipher.init(false, params); // Initialize cipher for decryption
    final encrypted =
        base64Decode(encryptedText); // Decode base64-encoded encrypted text
    final decrypted = cipher.process(encrypted); // Decrypt the bytes
    return utf8.decode(decrypted); // Convert decrypted bytes back to string
  }
}
