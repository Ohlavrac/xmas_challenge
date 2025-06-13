import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContentProvider extends ChangeNotifier{
  String content = "";
  List<List<String>>? matrix;

  void readContent(String path) async {
    content = await rootBundle.loadString(path);

    while (content.isEmpty) {
      continue;
    }
    notifyListeners();
  }

  void fileToMatrix(String content) {

    if (matrix == null) {
      matrix = [];

      //coisas do windows  (normalmente windows usa \r\n)
      content = content.replaceAll('\r', '');

      List<String> lines = content.split('\n');

      for (int y = 0; y < lines.length; y++) {
        matrix?.add([]);
        for (int x = 0; x < lines[y].length; x++) {
          matrix?[y].add(lines[y][x]);
        }
      }
    } else {
      null;
    }

    print(matrix);

    notifyListeners();
  }

  void xmasFinder() {
    List<List<int>> coordToSave = [];

    List<String> targets = ['XMAS', 'SAMX'];

    List<List<int>> directions = [
      [0, 1],
      [0, -1],
      [1, 0],  
      [-1, 0], 
      [1, 1], 
      [1, -1],
      [-1, 1],
      [-1, -1], 
    ];

    int lineLength = matrix!.length;
    int columnLength = matrix![0].length;

    bool atLimit(int l, int c) =>
        l >= 0 && l < lineLength && c >= 0 && c < columnLength;

    for (int x = 0; x < lineLength; x++) {
      for (int y = 0; y < columnLength; y++) {

        for (int c = 0; c < directions.length; c++) {
          String word = "";

          List<int> direction =  directions[c];

          List<List<int>> coords = [];
          
          int auxX = x;
          int auxY = y;

          for (int k = 0; k < targets[0].length; k++) {
            if (atLimit(auxX, auxY)) {
              word += matrix![auxX][auxY];
              coords.add([auxX, auxY]);

              auxX += direction[0];
              auxY += direction[1];
            } else {
              break;
            }
          }

          if (targets.contains(word)) {
            for (int x = 0; x < coords.length; x++) {
              coordToSave.add(coords[x]);
            }
          }
        }
      }
    }

    for (int x = 0; x < matrix!.length; x++) {
      for (int y = 0; y < matrix![0].length; y++) {
        bool isValid = coordToSave.any((pos) => pos[0] == x && pos[1] == y);

        if (!isValid) {
          matrix![x][y] = '.';
        }
      }
    }
  }

  bool hasFile() {
    if (content.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}