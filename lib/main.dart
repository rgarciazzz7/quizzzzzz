import 'package:flutter/material.dart';
import 'package:quizzzzzz/quiz_main.dart'; 

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gênio Quiz - DBZ & Naruto',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: WelcomePage(), 
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gênio Quiz'),
        backgroundColor: const Color.fromARGB(255, 248, 58, 0), 
        foregroundColor: Colors.white, 
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 34, 228), 
              const Color.fromARGB(255, 248, 58, 0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 2),
                child: Image.asset(
                  'lib/assets/quiz_imagem.jpg', 
                  height: 400,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Bem-vindo ao Gênio Quiz!\n\nVamos ver o quanto você sabe sobre os universos de Dragon Ball e Naruto.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(3.0, 3.0),
                      blurRadius: 5.0,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/quiz');
                },
                child: Text('Iniciar Quiz'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  backgroundColor: Color.fromARGB(255, 248, 58, 0),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
