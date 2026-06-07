import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const QuizScreen(),
      },
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'What is the capital of France?',
      'answers': [
        {'text': 'Berlin', 'score': 0},
        {'text': 'Madrid', 'score': 0},
        {'text': 'Paris', 'score': 1},
        {'text': 'Rome', 'score': 0},
      ],
    },
    {
      'questionText': 'Which planet is known as the Red Planet?',
      'answers': [
        {'text': 'Earth', 'score': 0},
        {'text': 'Mars', 'score': 1},
        {'text': 'Jupiter', 'score': 0},
        {'text': 'Venus', 'score': 0},
      ],
    },
    {
      'questionText': 'What is the largest mammal in the world?',
      'answers': [
        {'text': 'Elephant', 'score': 0},
        {'text': 'Blue Whale', 'score': 1},
        {'text': 'Giraffe', 'score': 0},
        {'text': 'Hippopotamus', 'score': 0},
      ],
    },
    {
      'questionText': 'Which element has the chemical symbol "O"?',
      'answers': [
        {'text': 'Gold', 'score': 0},
        {'text': 'Oxygen', 'score': 1},
        {'text': 'Osmium', 'score': 0},
        {'text': 'Ozone', 'score': 0},
      ],
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _currentQuestionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _score = 0;
      _currentQuestionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Quiz App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _currentQuestionIndex < _questions.length
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _questions[_currentQuestionIndex]['questionText'] as String,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ...(_questions[_currentQuestionIndex]['answers']
                            as List<Map<String, Object>>)
                        .map((answer) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                          ),
                          onPressed: () => _answerQuestion(answer['score'] as int),
                          child: Text(
                            answer['text'] as String,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    }),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        size: 80,
                        color: Colors.amber,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Quiz Completed!',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'You answered $_score correctly out of ${_questions.length}!',
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: _resetQuiz,
                        child: const Text('Restart Quiz'),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
