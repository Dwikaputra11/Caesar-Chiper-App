class Security {
  String encryptRailFence(String text, int key) {
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

  String decryptRailFence(String cipher, int key) {
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
