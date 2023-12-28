import 'dart:math';

import 'package:crypto/models/keys.dart';

class GenereteKeys {
  Keys genereteKeys() {
    int p = primeValues[Random().nextInt(25)];
    int q = primeValues[Random().nextInt(25)];
    int n = p * q;

    // função totiente
    int phi = (p - 1) * (q - 1);

    // public key
    int e = _findE(phi);

    int priviceKey = _getPrivaciKey(e, phi);

    return Keys(public: e, private: priviceKey, n: n);
  }

  int _getPrivaciKey(int e, int phi) {
    int m0 = phi;
    int x0 = 0, x1 = 1;

    if (phi == 1) return 0;

    while (e > 1) {
      int q = e ~/ phi;

      int temp = phi;

      phi = e % phi;
      e = temp;

      temp = x0;
      x0 = x1 - q * x0;
      x1 = temp;
    }

    if (x1 < 0) x1 += m0;

    return x1;
  }

  int _findE(int phi) {
    while (true) {
      int value = primeValues[Random().nextInt(25)];
      if (value > 1 && value < phi && value.gcd(phi) == 1) return value;
    }
  }

  Keys createPublicKey(String nameKey, String publicKey, String n) {
    try {
      int? pParse = int.tryParse(publicKey);
      int? nParse = int.tryParse(n);
      if (pParse != null && nParse != null) {
        return Keys(name: nameKey, public: pParse, private: -1, n: nParse);
      } else {
        throw const FormatException("Data is not Integer.");
      }
    } catch (e) {
      throw const FormatException("Data is not Interge.");
    }
  }

  List<int> primeValues = [
    2,
    3,
    5,
    7,
    11,
    13,
    17,
    19,
    23,
    29,
    31,
    37,
    41,
    43,
    47,
    53,
    59,
    61,
    67,
    71,
    73,
    79,
    83,
    89,
    97
  ];
}
