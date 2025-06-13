import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContentProvider extends ChangeNotifier{
  String content = "";
  List<List<String>>? matrix;

  void readContent(String path) async {
    content = await rootBundle.loadString(path);
    notifyListeners();
  }

  void fileToMatrix(String content) {

    if (matrix == null) {
      matrix = [];
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

    notifyListeners();
  }

  bool hasFile() {
    print(content);
    if (content.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}