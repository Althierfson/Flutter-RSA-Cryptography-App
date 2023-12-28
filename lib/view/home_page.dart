import 'package:crypto/controllers/crypt.dart';
import 'package:crypto/controllers/generete_keys.dart';
import 'package:crypto/controllers/save_keys.dart';
import 'package:crypto/models/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GenereteKeys _genereteKeys = GenereteKeys();
  final Crypt _crypt = Crypt();
  late SaveKeys _saveKeys;

  @override
  void initState() {
    setSaveKeys();
    super.initState();
  }

  setSaveKeys() async {
    _saveKeys = SaveKeys(shared: await SharedPreferences.getInstance());
    _listKeys = _saveKeys.getKeys();
    setState(() {});
  }

  List<Keys> _listKeys = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Key list"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                        _listKeys.length,
                        (index) => ListTile(
                              title: Text(_listKeys[index].name),
                              leading: IconButton(
                                  onPressed: () {
                                    _listKeys.removeAt(index);
                                    _saveKeys.saveKeys(_listKeys);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.delete)),
                              trailing: IconButton(
                                  onPressed: () {
                                    _showEditKeysName(index);
                                  },
                                  icon: const Icon(Icons.more_vert)),
                              onTap: () {
                                _showCryptDialog(_listKeys[index]);
                              },
                            )),
                  ),
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _showAddNewKey();
                    },
                    child: const Text("Add Public Key")),
                ElevatedButton(
                    onPressed: () {
                      final k = _genereteKeys.genereteKeys();
                      _listKeys.add(k);
                      _saveKeys.saveKeys(_listKeys);
                      setState(() {});
                    },
                    child: const Text("Generate Keys"))
              ],
            )
          ],
        ),
      )),
    );
  }

  void _showCryptDialog(Keys keys) {
    bool encrypt = true;
    String msg = "";
    String finalMsg = "";

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Encrypt/Decrypt"),
                keys.private != -1
                    ? Text("Private Key: ${keys.private}")
                    : Container(),
                Text("Public Key: ${keys.public}"),
                Text("N: ${keys.n}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Encrypt"),
                    Radio(
                        value: true,
                        groupValue: encrypt,
                        onChanged: (value) {
                          encrypt = value!;
                          setState(() {});
                        }),
                    keys.private != -1 ? const Text("decrypt") : Container(),
                    keys.private != -1
                        ? Radio(
                            value: false,
                            groupValue: encrypt,
                            onChanged: (value) {
                              encrypt = value!;
                              setState(() {});
                            })
                        : Container()
                  ],
                ),
                TextField(
                  decoration: const InputDecoration(labelText: "Text"),
                  maxLines: 2,
                  onChanged: (value) => msg = value,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (encrypt) {
                        finalMsg = _crypt.encryptMessage(keys, msg);
                        setState(() {});
                      } else {
                        finalMsg = _crypt.decryptMessage(keys, msg);
                        setState(() {});
                      }
                    },
                    child: const Text("Run Cryptography")),
                Text(encrypt ? "Encrypt Text" : "Decrypt Text"),
                Row(
                  children: [
                    Expanded(child: Text(finalMsg)),
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: finalMsg));
                        },
                        icon: const Icon(Icons.copy))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddNewKey() {
    String nameKey = "";
    String publicKey = "";
    String n = "";
    String result = "";
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text("Add public key"),
                        TextField(
                          decoration:
                              const InputDecoration(hintText: "Key Name"),
                          onChanged: (value) => nameKey = value,
                        ),
                        TextField(
                          decoration:
                              const InputDecoration(hintText: "Public Key"),
                          onChanged: (value) => publicKey = value,
                        ),
                        TextField(
                          decoration: const InputDecoration(hintText: "N"),
                          onChanged: (value) => n = value,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              try {
                                final keys = _genereteKeys.createPublicKey(
                                    nameKey, publicKey, n);
                                _listKeys.add(keys);
                                _saveKeys.saveKeys(_listKeys);
                                result = "New key add.";
                              } on Exception catch (e) {
                                result = e.toString();
                              }
                              setState(() {});
                            },
                            child: const Text("Add new public key")),
                        Text(result)
                      ],
                    ),
                  ),
                ))).then((value) {
      setState(() {});
    });
  }

  void _showEditKeysName(int index) {
    String name = "";
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller:
                          TextEditingController(text: _listKeys[index].name),
                      decoration: const InputDecoration(labelText: "Name"),
                      onChanged: (value) => name = value,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _listKeys[index].name = name;
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: const Text("Save"))
                  ],
                ),
              ),
            ));
  }
}
