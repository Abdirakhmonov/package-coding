import 'package:najot_coding/najot_coding.dart';

void main() {
  final keyString = 'my32lengthsupersecretnooneknows1'; // 32 ta belgi
  final najotCodingService = NajotCodingService(keyString);

  final plainText = 'Hello, Dart!';
  final encryptedText = najotCodingService.encrypt(plainText);
  print('Encrypted: $encryptedText');

  final decryptedText = najotCodingService.decrypt(encryptedText);
  print('Decrypted: $decryptedText');
}
