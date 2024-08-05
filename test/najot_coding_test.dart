import 'package:test/test.dart';
import 'package:najot_coding/najot_coding.dart';

void main() {
  group('NajotCodingService Tests', () {
    final keyString = 'your-32-character-key';
    final najotCodingService = NajotCodingService(keyString);
    final plainText = 'Hello, Najot Coding!';
    late String encryptedText;

    setUp(() {
      // Additional setup if needed.
    });

    test('Encrypt Test', () {
      encryptedText = najotCodingService.encrypt(plainText);
      expect(encryptedText, isNotNull);
      expect(encryptedText, isNot(plainText));
    });

    test('Decrypt Test', () {
      encryptedText = najotCodingService.encrypt(plainText);
      final decryptedText = najotCodingService.decrypt(encryptedText);
      expect(decryptedText, equals(plainText));
    });

    test('Encryption and Decryption Consistency', () {
      encryptedText = najotCodingService.encrypt(plainText);
      final decryptedText = najotCodingService.decrypt(encryptedText);
      expect(decryptedText, equals(plainText));
    });
  });
}
