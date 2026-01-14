import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:odev/piece.dart';
import 'package:odev/pixel.dart';
import 'package:odev/values.dart';


//OYUN TAHTASI
List<List<Tetris?>> gameBoard = List.generate(
  dikeyUzunluk,
  (i) => List.generate(
    yatayUzunluk, (j) => null,
  ),
);

class GameBoard extends StatefulWidget{
  const GameBoard({super.key});
  
  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  Piece currentPiece = Piece(type: Tetris.L); //İLK HAREKET EDEN BLOK
  int currentScore = 0; //SKOR
  bool gameOver = false; //OYUNUN BİTİP BİTMEDİĞİ

  @override
  void initState() {
    super.initState();

    startGame(); //OYUNU BAŞLATIR VE ZAMANLAYICI BAŞLATIR
  }

  void startGame() {
    currentPiece.initiazlizePiece();

    Duration frameRate = const Duration(milliseconds: 500);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
      (timer) {
        setState(() {

          clearLines(); //DOLU SATIRLARI TEMİZLER
          checkLanding(); //BLOK'UN YERE İNİP İNMEDİĞİNİ KONTROL EDER

          //oyunun bitip bitmediğini kontrol
          if (gameOver == true) {
            timer.cancel(); //OYUN BİTİNCE DÖNGÜ DURUR
            showGameOverDialog(); //OYUNCUYA MESAJ
          }

          currentPiece.movePiece(Direction.asagi); //BLOĞU AŞAĞI HAREKET ETTİRİR
        });
      },
    );
  }

  //oyun bitti mesajı
  void showGameOverDialog(){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Oyun Bitti'),
      content: Text('Skorunuz: $currentScore'),
      actions: [
        TextButton(onPressed: (){
          resetGame();
          
          Navigator.pop(context);
        }, child: Text('Tekrar Oyna!'))
      ],
    ),);
  }

  void resetGame() {
    gameBoard = List.generate(dikeyUzunluk,
       (i) => List.generate(
          yatayUzunluk,
           (j) => null,
       ),
    );

    //yeni oyun
    gameOver = false;
    currentScore = 0;


    createNewPiece();
    startGame();
  }

  //BLOKLARIN ÇARPIŞMA KONTROLÜ
  bool checkCollision(Direction direction){
    for (int i = 0; i < currentPiece.position.length; i++){
      int row = (currentPiece.position[i] / yatayUzunluk).floor();
      int col = currentPiece.position[i] % yatayUzunluk;

      if (direction == Direction.sol) {
        col -= 1;
      } else if (direction == Direction.sag) {
        col += 1;
      } else if (direction == Direction.asagi) {
        row += 1;
      }

      if (row >= dikeyUzunluk || col <0 || col >= yatayUzunluk || (row >= 0 && gameBoard[row][col] != null)) {
        return true;
      }
    }
    return false;
  }

  //TAHTA GÜNCELLEME
  void checkLanding() {
    if (checkCollision(Direction.asagi)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / yatayUzunluk).floor();
        int col = currentPiece.position[i] % yatayUzunluk;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      createNewPiece();
    }
  }

  //YENİ PARÇA OLUŞTURMA
  void createNewPiece(){
    Random rand = Random();

    Tetris randomType =
        Tetris.values[rand.nextInt(Tetris.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initiazlizePiece();

    if(isGameOver()) {
      gameOver = true;
    }
  }

  //SOL
  void moveLeft() {
    if (!checkCollision(Direction.sol)) {
      setState(() {
        currentPiece.movePiece(Direction.sol);
      });
    }
  }

  //SAĞ
  void moveRight() {
    if (!checkCollision(Direction.sag)) {
      setState(() {
        currentPiece.movePiece(Direction.sag);
      });
    }
  }

  //DÖNDÜRME
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  //TEKTE İNDİR
  void hardDrop() {
    setState(() {
      while (!checkCollision(Direction.asagi)) {
        currentPiece.movePiece(Direction.asagi);
      }
      checkLanding();
    });
  }

  //SATIR TEMİZLEME VE SKOR GÜNCELLEME
  void clearLines() {
    for (int row = dikeyUzunluk - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (int col = 0; col < yatayUzunluk; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      if(rowIsFull){
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r-1]);
        }

        gameBoard[0] = List.generate(row, (index) => null);

        currentScore++;
      }
    }
  }

  //OYUN BİTTİ
  bool isGameOver(){
    for (int col = 0; col < yatayUzunluk; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    return false;
  }

  //EKRAN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: yatayUzunluk * dikeyUzunluk,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: yatayUzunluk),
              itemBuilder: (context, index) {
                int row = (index / yatayUzunluk).floor();
                int col = index % yatayUzunluk;
            
                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    color: currentPiece.color,
                  );
                } else if (gameBoard[row][col] != null) {
                  final Tetris? tetrisType = gameBoard[row][col];
                  return Pixel(color: tetrisColors[tetrisType]);
                }
                else {
                  return Pixel(
                    color: Colors.grey[900],
                  );
                }
              },
            ),
          ),

          //SKOR
          Text('Score: $currentScore', style: TextStyle(color: Colors.white)
          ),

          //OYUN KONTROLLERİ
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //sol
                  IconButton(
                      onPressed: moveLeft,
                      color: Colors.white,
                      icon: Icon(Icons.arrow_back)
                  ),

                  //döndür
                  IconButton(
                      onPressed: rotatePiece,
                      color: Colors.white,
                      icon: Icon(Icons.refresh)
                  ),

                  //sağ
                  IconButton(
                      onPressed: moveRight,
                      color: Colors.white,
                      icon: Icon(Icons.arrow_forward)
                  ),

                  //tekte indir
                  IconButton(
                    onPressed: hardDrop,
                    color: Colors.white,
                    icon: Icon(Icons.arrow_downward),
                  ),
                ],)
          )
        ],
      ),
    );
  }
}
