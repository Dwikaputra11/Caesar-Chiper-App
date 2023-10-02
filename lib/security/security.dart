class Security {
  static String encryptCaesar(String text, int key) {
    String cipherText = '';
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      if (char.contains(RegExp(r'[A-Za-z]'))) {
        // Convert the character to its ASCII code
        int asciiCode = char.codeUnitAt(0);
        // Determine if the character is uppercase or lowercase
        if (char == char.toUpperCase()) {
          // Apply the shift to the ASCII code of the character, wrapping around if necessary
          int shiftedCode = (asciiCode - 65 + key) % 26 + 65;
          // Convert the shifted ASCII code back to a character
          char = String.fromCharCode(shiftedCode);
        } else {
          int shiftedCode = (asciiCode - 97 + key) % 26 + 97;
          char = String.fromCharCode(shiftedCode);
        }
      }
      // Append the encrypted character to the cipher text
      cipherText += char;
    }

    return cipherText;
  }

  static decryptCaesar(String text, int key) {
    String cipherText = text;
    String plainText = '';
    for (int i = 0; i < cipherText.length; i++) {
      String char = cipherText[i];
      if (char.contains(RegExp(r'[A-Za-z]'))) {
        int asciiCode = char.codeUnitAt(0);
        if (char == char.toUpperCase()) {
          int shiftedCode = (asciiCode - 65 - key) % 26 + 65;
          char = String.fromCharCode(shiftedCode);
        } else {
          int shiftedCode = (asciiCode - 97 - key) % 26 + 97;
          char = String.fromCharCode(shiftedCode);
        }
      }
      plainText += char;
    }
    return plainText;
  }

  static String generateKey(String str, String key) {
    int x = str.length;

    for (int i = 0; true; i++) {
      if (x == i) {
        i = 0;
      }
      if (key.length == str.length) {
        break;
      }
      key += key[i];
    }
    return key;
  }

  static encryptVigenere(String text, String key) {
    String cipherText = '';

    for (int i = 0; i < text.length; i++) {
      // Converting in range 0-25
      int x = (text.codeUnitAt(i) + key.codeUnitAt(i)) % 26;

      // Convert into alphabets (ASCII)
      x += 'A'.codeUnitAt(0);

      cipherText += String.fromCharCode(x);
    }
    return cipherText;
  }

  static decryptVigenere(String text, String key) {
    String origText = '';

    for (int i = 0; i < text.length; i++) {
      // Converting in range 0-25
      int x = (text.codeUnitAt(i) - key.codeUnitAt(i) + 26) % 26;

      // Convert into alphabets (ASCII)
      x += 'A'.codeUnitAt(0);
      origText += String.fromCharCode(x);
    }
    return origText;
  }

  static String encryptRailFence(String text, int key) {
    // Create the matrix to cipher plain text
    // key = rows, text.length = columns
    List<List<String>> rail =
        List.generate(key, (i) => List<String>.filled(text.length, '\n'));

    bool dirDown = false;
    int row = 0, col = 0;

    for (int i = 0; i < text.length; i++) {
      // Check the direction of flow
      // Reverse the direction if we've just
      // filled the top or bottom rail
      if (row == 0 || row == key - 1) {
        dirDown = !dirDown;
      }

      // Fill the corresponding character
      rail[row][col++] = text[i];

      // Find the next row using the direction flag
      if (dirDown) {
        row++;
      } else {
        row--;
      }
    }

    // Now we can construct the cipher using the rail matrix
    String result = '';
    for (int i = 0; i < key; i++) {
      for (int j = 0; j < text.length; j++) {
        if (rail[i][j] != '\n') {
          result += rail[i][j];
        }
      }
    }

    return result;
  }

  static String decryptRailFence(String cipher, int key) {
    // Create the matrix to decipher plain text
    // key = rows, cipher.length = columns
    List<List<String>> rail =
        List.generate(key, (i) => List<String>.filled(cipher.length, '\n'));

    // To find the direction
    bool dirDown = true;
    int row = 0, col = 0;

    // Mark the places with '*'
    for (int i = 0; i < cipher.length; i++) {
      // Check the direction of flow
      if (row == 0) {
        dirDown = true;
      }
      if (row == key - 1) {
        dirDown = false;
      }

      // Place the marker
      rail[row][col++] = '*';

      // Find the next row using the direction flag
      if (dirDown) {
        row++;
      } else {
        row--;
      }
    }

    // Now we can construct and fill the rail matrix
    int index = 0;
    for (int i = 0; i < key; i++) {
      for (int j = 0; j < cipher.length; j++) {
        if (rail[i][j] == '*' && index < cipher.length) {
          rail[i][j] = cipher[index++];
        }
      }
    }

    String result = '';
    row = 0;
    col = 0;
    for (int i = 0; i < cipher.length; i++) {
      // Check the direction of flow
      if (row == 0) {
        dirDown = true;
      }
      if (row == key - 1) {
        dirDown = false;
      }

      // Place the marker
      if (rail[row][col] != '*') {
        result += rail[row][col++];
      }

      // Find the next row using the direction flag
      if (dirDown) {
        row++;
      } else {
        row--;
      }
    }

    return result;
  }
}
