// kareler
import 'dart:ui';

int yatayUzunluk = 10; //YATAY HÜCRE SAYISI
int dikeyUzunluk = 15; //DİKEY HÜCRE SAYISI

enum Direction{
  sol,
  sag,
  asagi
}

enum Tetris{
  L,
  J,
  I,
  O,
  S,
  Z,
  T,

  /*
    o
    o
    o o

      o
      o
    o o

    o
    o
    o
    o

    o o
    o o

      o o
    o o

    o o
      o o

    o
    o o
    o

  */
}

//BLOK RENKLERİ
const Map<Tetris, Color> tetrisColors = {
  Tetris.L: Color(0xFFFFA500), //TURUNCU
  Tetris.J: Color.fromARGB(255, 0, 102, 255), //MAVİ
  Tetris.I: Color.fromARGB(255, 242, 0, 255), //PEMBE
  Tetris.O: Color(0xFFFFFF00), //SARI
  Tetris.S: Color(0XFF008000), //YEŞİL
  Tetris.Z: Color(0XFFFF0000), //KIRMIZI
  Tetris.T: Color.fromARGB(255, 144, 0, 255), //PEMBE
};
