import 'package:flutter/material.dart';

class VigenereCipherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vigenere Cipher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VigenereCipherPage(),
    );
  }
}

class VigenereCipherPage extends StatefulWidget {
  @override
  _VigenereCipherPageState createState() => _VigenereCipherPageState();
}

class _VigenereCipherPageState extends State<VigenereCipherPage> {
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _keywordEditingController = TextEditingController();
  int _shift = 3;
  String _resultencryption = '';
  String _resultdecryption = '';

  bool _isLetter(String text) {
    return RegExp(r'[a-zA-Z]').hasMatch(text);
  }

  bool _isUppercase(String text) {
    return text == text.toUpperCase();
  }

  String _encrypt(String text, String keyword) {
    String result = "";
    for (int i = 0; i < text.length; i++) {
      if (_isLetter(text[i])) {
        String base = _isUppercase(text[i]) ? 'A' : 'a';
        int charCode = base.codeUnitAt(0);
        int shift =
            keyword[i % keyword.length].toUpperCase().codeUnitAt(0) -
                'A'.codeUnitAt(0);
        result += String.fromCharCode(
            (charCode + (text.codeUnitAt(i) - charCode + shift) % 26));
      } else {
        result += text[i];
      }
    }
    return result;
  }

  

  String _decrypt(String text, String keyword) {
    String result = "";
    for (int i = 0; i < text.length; i++) {
      if (_isLetter(text[i])) {
        String base = _isUppercase(text[i]) ? 'A' : 'a';
        int charCode = base.codeUnitAt(0);
        int shift =
            keyword[i % keyword.length].toUpperCase().codeUnitAt(0) -
                'A'.codeUnitAt(0);
        result += String.fromCharCode(
            (charCode + (text.codeUnitAt(i) - charCode - shift + 26) % 26));
      } else {
        result += text[i];
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vigenere Cipher'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Text',
              ),
            ),
            TextField(
              controller: _keywordEditingController,
              decoration: InputDecoration(
                labelText: 'Keyword',
              ),
            ),

            SizedBox(height: 16.0),

            ElevatedButton(
              onPressed: () {
                String inputText = _textEditingController.text;
                String keyword = _keywordEditingController.text;
                String encryptedText = _encrypt(inputText, keyword);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Hasil Enkripsi'),
                      content: Text(encryptedText),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Tutup'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Enkripsi'),
            ),

            ElevatedButton(
              onPressed: () {
                String inputText = _textEditingController.text;
                String keyword = _keywordEditingController.text;
                String decryptedText = _decrypt(inputText, keyword);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Hasil Dekripsi'),
                      content: Text(decryptedText),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Tutup'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Dekripsi'),
            ),
          ],
        ),
      ),
    );
  }
}




