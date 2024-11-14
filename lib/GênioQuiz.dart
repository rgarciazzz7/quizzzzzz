import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gênio Quiz - Dragon Ball e Naruto',
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/quiz': (context) => QuizPage(),
      },
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gênio Quiz'),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 248, 58, 0),
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

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isAnswered = false;
  int _timeLeft = 10;
  Timer? _timer;
  bool _isTimeUp = false;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': '1 - Qual o nome do irmão mais velho de Goku?',
      'options': ['Kakarotto', 'Raditz', 'Vegeta', 'Bardock'],
      'answer': 1,
      'imagem': 'lib/assets/imagem_questao_1.jpeg',
    },
    {
      'question': '2 - Quem foi o vencedor do Torneio do Poder?',
      'options': ['Android 17 - Universo 7', 'Jiren - Universo 11', 'Goku - Universo 7', 'Freeza - Universo 7'],
      'answer': 0,
      'imagem': 'lib/assets/imagem_questao_2.jpg',
    },
    {
      'question': '3 - Qual versão do Majin Buu é a mais forte?',
      'options': ['Evil Buu', 'Kid Buu', 'Majin Buu Gohan (absorvido)', 'Majin Buu Gotenks (absorvido)'],
      'answer': 2,
      'imagem': 'lib/assets/imagem_questao_3.png',
    },
    {
      'question': '4 - Qual o nome do avô de Goku?',
      'options': ['Gohan', 'Mestre Kame', 'Tenshinhan', 'Tao Pai Pai'],
      'answer': 0,
      'imagem': 'lib/assets/imagem_questao_4.jpg',
    },
    {
      'question': '5 - Quantos Shenlongs existem oficialmente?',
      'options': ['4', '11', '7', '6'],
      'answer': 3,
      'imagem': 'lib/assets/imagem_questao_5.jpeg',
    },
    {
      'question': '6 - Em Boruto - Two Blue Vortex, quem aprisionou Naruto e Hinata em uma dimensão alternativa?',
      'options': ['Code', 'Sasuke Uchiha', 'Kawaki Uzumaki', 'Boruto Uzumaki'],
      'answer': 2,
      'imagem': 'lib/assets/imagem_questao_6.jpeg',
    },
    {
      'question': '7 - Como se chama o ninjutsu de espaço-tempo utilizado por Sasuke Uchiha?',
      'options': ['Ame-No-Tejikara', 'Shibaku Tensei', 'Shinra Tensei', 'Hiraishin'],
      'answer': 0,
      'imagem': 'lib/assets/imagem_questao_7.png',
    },
    {
      'question': '8 - Qual desses personagens não foi / não é Hokage?',
      'options': ['Kakashi Hatake', 'Shikamaru Nara', 'Hiruzen Sarutobi', 'Tsunade Senju', 'Nenhuma das alternativas'],
      'answer': 4,
      'imagem': 'lib/assets/imagem_questao_8.jpg',
    },
    {
      'question': '9 - Qual o nome da Bijuu de 7 caudas?',
      'options': ['Kurama', 'Shukaku', 'Choumei', 'Son Gokuu'],
      'answer': 2,
      'imagem': 'lib/assets/imagem_questao_9.jpeg',
    },
    {
      'question': '10 - Quem matou Konan?',
      'options': ['Pain', 'Kisame', 'Obito Uchiha', 'Itachi Uchiha'],
      'answer': 2,
      'imagem': 'lib/assets/imagem_questao_10.jpeg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timeLeft = 10;
    _stopTimer();
    _isTimeUp = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        setState(() {
          _isTimeUp = true; 
        });
        _stopTimer();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Tempo esgotado!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));
      } else {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  void _stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  void _answerQuestion(int selectedOption) {
    if (_isTimeUp) return; 

    bool isCorrect = selectedOption == _questions[_currentQuestionIndex]['answer'];
    if (isCorrect) {
      _score += 10;
    }

    setState(() {
      _isAnswered = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        isCorrect ? 'Resposta correta!' : 'Resposta errada!',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: isCorrect ? Colors.green : Colors.red,
      duration: Duration(seconds: 1),
    ));

    _stopTimer();
    Future.delayed(Duration(seconds: 2), _goToNextQuestion);
  }

  void _goToNextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _isAnswered = false;
        _startTimer(); 
      } else {
        _showFinalScore();
      }
    });
  }

  void _showFinalScore() {
    String message = "Você acertou $_score pontos!";
    if (_score == 100) {
      message = "Parabéns! Você é um verdadeiro gênio!";
    } else if (_score >= 80) {
      message = "Muito bem! Você é incrível!";
    } else if (_score >= 50) {
      message = "Boa! Mas pode melhorar!";
    } else {
      message = "Você pode melhorar, tente novamente!";
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Quiz Finalizado!'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetQuiz();
            },
            child: Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }

  void _resetQuiz() {
    setState(() {
      _score = 0;
      _currentQuestionIndex = 0;
      _isAnswered = false;
      _isTimeUp = false;
      _stopTimer();
    });

    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gênio Quiz - Dragon Ball e Naruto'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 0, 34, 228),
        child: Center(
          child: _currentQuestionIndex < _questions.length
              ? _buildQuizContent()
              : _buildFinalScreen(),
        ),
      ),
    );
  }

  Widget _buildQuizContent() {
    final question = _questions[_currentQuestionIndex];

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Sua pontuação: $_score',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Image.asset(
            question['imagem'],
            height: 250,
          ),
          SizedBox(height: 20),
          
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: _timeLeft / 10),
            duration: Duration(seconds: 1),
            builder: (context, value, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 8,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Color.lerp(Colors.red, Colors.green, value)!),
                    ),
                  ),
                  Positioned(
                    child: Text(
                      '${_timeLeft}s',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 20),
          
          _isTimeUp
            ? ElevatedButton(
                onPressed: _resetQuiz, 
                child: Text("Tente Novamente"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  backgroundColor: Color.fromARGB(255, 248, 58, 0),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            : _buildQuizQuestion(),
        ],
      ),
    );
  }

  Widget _buildFinalScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Você completou o quiz, parabéns!!',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        SizedBox(height: 20),
        Image.asset(
          'lib/assets/quiz_imagem.jpg',
          height: 250,
        ),
      ],
    );
  }

  Widget _buildQuizQuestion() {
    final question = _questions[_currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            question['question'],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20),
          ...List.generate(question['options'].length, (index) {
            return ElevatedButton(
              onPressed: !_isAnswered ? () => _answerQuestion(index) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 248, 58, 0),
              ),
              child: Text(question['options'][index], style: TextStyle(color: Colors.white)),
            );
          }),
        ],
      ),
    );
  }
}
