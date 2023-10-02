import 'package:caesar_chiper_app/security/security.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController etText = TextEditingController();
  TextEditingController etAnswer = TextEditingController();
  TextEditingController etKeyword = TextEditingController();
  int shift = 3;
  int method = 1;
  String keyword = '';
  bool isKeywordVisible = false;

  @override
  Widget build(BuildContext context) {
    String result = '';

    List<DropdownMenuEntry<int>> menuItems = [
      const DropdownMenuEntry(value: 1, label: "Caesar Chiper"),
      const DropdownMenuEntry(value: 2, label: "Vigenere Chiper"),
      const DropdownMenuEntry(value: 3, label: "Rail-Fence Chiper"),
      const DropdownMenuEntry(value: 4, label: "Super Encryption"),
    ];

    void encrypt() {
      var txt = etText.text;
      var ans = '';
      if (txt.isNotEmpty) {
        switch (method) {
          case 1:
            ans = Security.encryptCaesar(txt, shift);
            break;
          case 2:
            keyword = etKeyword.text;
            ans = Security.encryptVigenere(txt, keyword);
            break;
          case 3:
            ans = Security.encryptRailFence(txt, shift);
            break;
          case 4:
            ans = Security.encryptSuper(txt, shift);
            break;
          default:
        }
      }
      etAnswer.text = "$txt --> $ans";
    }

    void decrypt() {
      var txt = etText.text;
      var ans = '';
      if (txt.isNotEmpty) {
        switch (method) {
          case 1:
            ans = Security.decryptCaesar(txt, shift);
            break;
          case 2:
            keyword = etKeyword.text;
            ans = Security.decryptVigenere(txt, keyword);
            break;
          case 3:
            ans = Security.decryptRailFence(txt, shift);
            break;
          case 4:
            ans = Security.decryptSuper(txt, shift);
            break;
          default:
        }
      }
      etAnswer.text = "$txt --> $ans";
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Encrypt/Decrypt'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: etText,
              decoration: const InputDecoration(
                hintText: 'Enter a message to encrypt/decrypt ',
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('method: '),
                const SizedBox(width: 16.0),
                DropdownMenu<int>(
                  initialSelection: method,
                  dropdownMenuEntries: menuItems,
                  onSelected: (value) {
                    setState(() {
                      method = value!;
                      isKeywordVisible = method == 2;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Visibility(
              visible: isKeywordVisible,
              child: TextField(
                controller: etKeyword,
                decoration: const InputDecoration(
                  hintText: 'Enter a keyword',
                ),
              ),
            ),
            Visibility(
              visible: !isKeywordVisible,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('key: '),
                  const SizedBox(width: 16.0),
                  DropdownMenu<int>(
                    initialSelection: shift,
                    dropdownMenuEntries: List.generate(26, (i) => i + 1)
                        .map((i) => DropdownMenuEntry(
                              value: i,
                              label: i.toString(),
                            ))
                        .toList(),
                    onSelected: (value) {
                      setState(() {
                        shift = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: encrypt,
                  child: const Text('Encrypt'),
                ),
                const SizedBox(
                  width: 150,
                ),
                ElevatedButton(
                  onPressed: decrypt,
                  child: const Text('Decrypt'),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                const Text('Result'),
                TextField(
                  controller: etAnswer,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: result,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
