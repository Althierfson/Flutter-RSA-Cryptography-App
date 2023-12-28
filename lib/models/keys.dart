import 'dart:convert';

class Keys {
  String name;
  final int public;
  final int private;
  final int n;

  Keys(
      {required this.public,
      required this.private,
      required this.n,
      this.name = "New Keys"});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'public': public,
      'private': private,
      'n': n,
    };
  }

  factory Keys.fromMap(Map<String, dynamic> map) {
    return Keys(
      name: map['name'] as String,
      public: map['public'] as int,
      private: map['private'] as int,
      n: map['n'] as int,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory Keys.fromJson(String source) =>
      Keys.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
