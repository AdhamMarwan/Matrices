import 'dart:io';
void main() {
  print('Enter the number of matrices:');
  int nMatrices = int.parse(stdin.readLineSync()!);
  List<List<List<int>>> matrices = [];
  for (int i = 0; i < nMatrices; i++) {
    print('Matrix $i:');
    print('Enter the number of rows:');
    int rows = int.parse(stdin.readLineSync()!);
    print('Enter the number of columns:');
    int col = int.parse(stdin.readLineSync()!);
    matrices.add(createMatrix(rows, col));
  }
  print('Enter the operation you want to perform (addition, subtraction, multiplication):');
  String operation = stdin.readLineSync()!.toLowerCase();

  switch (operation) {
    case 'addition':
      performAddition(matrices);
      break;
    case 'subtraction':
      performSubtraction(matrices);
      break;
    case 'multiplication':
      performMultiplication(matrices);
      break;
    default:
      print('Invalid operation!');
  }
}

List<List<int>> createMatrix(int rows, int cols) {
  List<List<int>> matrix = [];
  for (int i = 0; i < rows; i++) {
    matrix.add([]);
    for (int j = 0; j < cols; j++) {
      print('Enter element  ($i, $j):');
      int element = int.parse(stdin.readLineSync()!);
      matrix[i].add(element);
    }
  }
  return matrix;
}

void performAddition(List<List<List<int>>> matrices) {
  List<List<int>> result = List.from(matrices[0]);

  for (int i = 1; i < matrices.length; i++) {
    if (matrices[i].length != result.length || matrices[i][0].length != result[0].length) {
      print('Error');
      return;
    }
    for (int row = 0; row < result.length; row++) {
      for (int col = 0; col < result[0].length; col++) {
        result[row][col] += matrices[i][row][col];
      }
    }
  }

  print('Result of addition:');
  printMatrix(result);
}

void performSubtraction(List<List<List<int>>> matrices) {
  List<List<int>> result = List.from(matrices[0]);

  for (int i = 1; i < matrices.length; i++) {
    if (matrices[i].length != result.length || matrices[i][0].length != result[0].length) {
      print('Error');
      return;
    }
    for (int row = 0; row < result.length; row++) {
      for (int col = 0; col < result[0].length; col++) {
        result[row][col] -= matrices[i][row][col];
      }
    }
  }

  print('Result of subtraction:');
  printMatrix(result);
}

void performMultiplication(List<List<List<int>>> matrices) {
  if (matrices.length < 2) {
    print('Error');
    return;
  }

  List<List<int>> result = List.from(matrices[0]);

  for (int i = 1; i < matrices.length; i++) {
    if (result[0].length != matrices[i].length || result.isEmpty || matrices[i].isEmpty) {
      print('Error');
      return;
    }
    result = multiplyMatrices(result, matrices[i]);
  }

  if (result.isEmpty) {
    print('Error');
    return;
  }

  print('Result of multiplication:');
  printMatrix(result);
}

List<List<int>> multiplyMatrices(List<List<int>> matrix1, List<List<int>> matrix2) {
  int rows1 = matrix1.length;
  int cols1 = matrix1[0].length;
  int rows2 = matrix2.length;
  int cols2 = matrix2[0].length;

  if (cols1 != rows2 || rows1 == 0 || cols1 == 0 || cols2 == 0) {
    return [[]];
  }

  List<List<int>> result = List.generate(rows1, (index) => List.filled(cols2, 0));
  for (int i = 0; i < rows1; i++) {
    for (int j = 0; j < cols2; j++) {
      for (int k = 0; k < cols1; k++) {
        result[i][j] += matrix1[i][k] * matrix2[k][j];
      }
    }
  }
  return result;
}
void printMatrix(List<List<int>> matrix) {
  for (List<int> row in matrix) {
    print(row);
  }
}