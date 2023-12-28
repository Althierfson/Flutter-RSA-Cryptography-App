import 'package:crypto/models/keys.dart';

class Crypt {
  String encryptMessage(Keys keys, String msg) {
    List<int> result = [];
    for (int i = 0; i < msg.length; i++) {
      int code = msg.codeUnitAt(i);
      //final cifra = pow(code, keys.public);
      //final value = cifra % keys.n;
      final value = _modPow(code, keys.public, keys.n);
      result.add(value);
    }
    return result.toString();
  }

  String decryptMessage(Keys keys, String msg) {
    List<int> list = [];
    try {
      list = _convertToMsgToList(msg);
    } on Exception {
      return "Out of Partten!";
    }
    String result = "";
    for (int i = 0; i < list.length; i++) {
      final value = _modPow(list[i], keys.private, keys.n);
      result = "$result${String.fromCharCode(value.toInt())}";
    }
    return result;
  }

  int _modPow(int base, int exponent, int modulus) {
    if (modulus == 1) return 0;
    int result = 1;
    base = base % modulus;
    while (exponent > 0) {
      if (exponent % 2 == 1) {
        result = (result * base) % modulus;
      }
      exponent = exponent >> 1;
      base = (base * base) % modulus;
    }
    return result;
  }

  List<int> _convertToMsgToList(String msg) {
    RegExp regex = RegExp(r'^\[\d+(, \d+)*\]$');

    if (!regex.hasMatch(msg)) {
      throw const FormatException('Out of Pattern.');
    }

    List<String> listString = msg
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map((e) => e.trim())
        .toList();

    List<int> listInt = listString.map((e) => int.parse(e)).toList();

    return listInt;
  }
}
