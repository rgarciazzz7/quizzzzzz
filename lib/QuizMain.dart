import 'package:flutter/material.dart';
import 'GênioQuiz.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gênio Quiz - Dragon Ball e Naruto')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/quiz_imagem.jpg',
            ),
            SizedBox(height: 20),
            Text(
              'Bem-vindo ao Gênio Quiz - DBZ & Naruto!',
              style: TextStyle(fontSize: 24),
            ), // Text
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaInicial()),
                );
              },
              child: Text('Iniciar o Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}