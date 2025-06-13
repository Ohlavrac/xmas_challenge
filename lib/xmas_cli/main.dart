import 'dart:io';

void main() {
  var file = File("./inputs/input_small.txt");  

  List<List<String>> matrix = fileToMatrix(file);

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

  int lineLength = matrix.length;
  int columnLength = matrix[0].length;

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
            word += matrix[auxX][auxY];
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

  showResult(matrix, coordToSave);
}

List<List<String>> fileToMatrix(File file) {
  List<String> lines = file.readAsLinesSync();

  List<List<String>> result = [];
  for (int y = 0; y < lines.length; y++) {
    result.add([]);
    for (int x = 0; x < lines[y].length; x++) {
      result[y].add(lines[y][x]);
    }
  }

  return result;
}

void showResult(List<List<String>> matrix, List<List<int>> coordToSave) {
  for (int x = 0; x < matrix.length; x++) {
    for (int y = 0; y < matrix[0].length; y++) {
      bool isValid = coordToSave.any((pos) => pos[0] == x && pos[1] == y);

      if (!isValid) {
        matrix[x][y] = '.';
      }
    }
  }

  for (int y = 0; y < matrix.length; y++) {
    print(matrix[y].join());
  }
}