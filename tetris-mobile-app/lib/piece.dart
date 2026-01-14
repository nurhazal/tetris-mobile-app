import 'dart:ui';
import 'package:odev/board.dart';
import 'values.dart';

//BLOKLARIN ŞEKİLLERİ
class Piece{
  //tetris şekli
  Tetris type;

  Piece({required this.type});

  List<int> position = [];

  Color get color {
    return tetrisColors[type] ??
        const Color(0xFFFFFFFF);
  }

  //HER BLOK BAŞLANGIÇ KISMINA YERLEŞTİRİLDİ
  void initiazlizePiece() {
    switch (type) {
      case Tetris.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetris.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetris.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetris.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetris.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetris.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetris.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.asagi:
        for (int i = 0; i < position.length; i++) {
          position[i] += yatayUzunluk;
        }
        break;
      case Direction.sol:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.sag:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  int rotationState = 1;
  void rotatePiece() {
    List<int> newPosition = [];

    switch (type) {
      case Tetris.L:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - dikeyUzunluk,
              position[1],
              position[1] + yatayUzunluk,
              position[1] + yatayUzunluk + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + yatayUzunluk - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + yatayUzunluk,
              position[1],
              position[1] - yatayUzunluk,
              position[1] - yatayUzunluk - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - yatayUzunluk +1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetris.J:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - yatayUzunluk,
              position[1],
              position[1] + yatayUzunluk,
              position[1] + yatayUzunluk + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + yatayUzunluk,
              position[1],
              position[1] - yatayUzunluk,
              position[1] - yatayUzunluk + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - yatayUzunluk +1,
              position[1],
              position[1] - 1,
              position[1] + yatayUzunluk + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetris.I:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - yatayUzunluk,
              position[1],
              position[1] + yatayUzunluk,
              position[1] + 2 * yatayUzunluk,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + yatayUzunluk,
              position[1],
              position[1] - yatayUzunluk,
              position[1] - 2 * yatayUzunluk,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetris.O:
        break;

      case Tetris.S:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + yatayUzunluk - 1,
              position[1] + yatayUzunluk,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - yatayUzunluk,
              position[0],
              position[0] + 1,
              position[0] + yatayUzunluk + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + yatayUzunluk - 1,
              position[1] - yatayUzunluk,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - yatayUzunluk,
              position[0],
              position[0] + 1,
              position[0] + yatayUzunluk + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetris.Z:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[0] + yatayUzunluk - 2,
              position[1],
              position[2] + yatayUzunluk - 1,
              position[3] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - yatayUzunluk + 2,
              position[1],
              position[2] - yatayUzunluk + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[0] + yatayUzunluk - 2,
              position[1],
              position[2] + yatayUzunluk - 1,
              position[3] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - yatayUzunluk + 2,
              position[1],
              position[2] - yatayUzunluk + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetris.T:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[2] - yatayUzunluk,
              position[2],
              position[2] + 1,
              position[2] + yatayUzunluk,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + yatayUzunluk,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] - yatayUzunluk,
              position[1] - 1,
              position[1],
              position[1] + yatayUzunluk,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[2] - yatayUzunluk,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
    }
  }

  bool positionIsValid(int position) {
    int row = (position / yatayUzunluk).floor();
    int col = position % yatayUzunluk;

    if(row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }
    else {
      return true;
    }
  }

  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      if (!positionIsValid(pos)) {
        return false;
      }
      int col = pos % yatayUzunluk;

      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == yatayUzunluk - 1) {
        lastColOccupied = true;
      }
    }

    return !(firstColOccupied && lastColOccupied);
  }
}