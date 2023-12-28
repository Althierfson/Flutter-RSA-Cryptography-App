import 'package:crypto/controllers/crypt.dart';
import 'package:crypto/controllers/generete_keys.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  late GenereteKeys keys;
  late Crypt crypt;

  setUp(() {
    keys = GenereteKeys();
    crypt = Crypt();
  });

  test("Generate keys", () {
    final result = keys.genereteKeys();

    debugPrint(result.n.toString());
    debugPrint(result.public.toString());
    debugPrint(result.private.toString());
  });

  test("encryptMessage", () {
    final k = keys.genereteKeys();

    debugPrint(k.n.toString());
    debugPrint(k.public.toString());
    debugPrint(k.private.toString());

    final encrypt = crypt.encryptMessage(k, "Hello World");

    debugPrint(encrypt);

    final decrypt = crypt.decryptMessage(k, encrypt);

    debugPrint(decrypt.toString());
  });
}
