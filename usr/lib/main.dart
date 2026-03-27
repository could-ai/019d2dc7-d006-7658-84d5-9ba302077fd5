import 'package:flutter/material.dart';

void main() {
  runApp(const ExamPrepApp());
}

class ExamPrepApp extends StatelessWidget {
  const ExamPrepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam Prep',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ExamQuestionsScreen(),
      },
    );
  }
}

class Question {
  final String question;
  final String answer;
  final String category;

  Question({required this.question, required this.answer, required this.category});
}

class ExamQuestionsScreen extends StatefulWidget {
  const ExamQuestionsScreen({super.key});

  @override
  State<ExamQuestionsScreen> createState() => _ExamQuestionsScreenState();
}

class _ExamQuestionsScreenState extends State<ExamQuestionsScreen> {
  // A list of important mock exam questions. 
  // Since we are in a Flutter environment, I've added Flutter/Dart questions!
  final List<Question> _questions = [
    Question(
      category: 'Flutter Basics',
      question: 'What is the difference between StatelessWidget and StatefulWidget?',
      answer: 'A StatelessWidget is immutable, meaning its properties cannot change once built. A StatefulWidget maintains state that can change over time, triggering a rebuild of the UI when setState() is called.',
    ),
    Question(
      category: 'Dart Programming',
      question: 'What is the difference between "const" and "final" in Dart?',
      answer: '"final" means the variable can only be set once and is initialized at runtime. "const" means the variable is a compile-time constant and must be initialized during compilation.',
    ),
    Question(
      category: 'Flutter Architecture',
      question: 'Explain the Flutter Widget Lifecycle.',
      answer: 'For StatefulWidgets, the lifecycle includes: createState(), initState(), didChangeDependencies(), build(), didUpdateWidget(), setState(), deactivate(), and dispose().',
    ),
    Question(
      category: 'State Management',
      question: 'What is BuildContext in Flutter?',
      answer: 'BuildContext is a locator that identifies a widget\'s position in the widget tree. It is used to look up inherited widgets, themes, media queries, and navigation routes.',
    ),
    Question(
      category: 'Dart Programming',
      question: 'How does Dart handle asynchronous programming?',
      answer: 'Dart uses Futures and Streams for asynchronous programming. The async/await keywords provide a declarative way to write asynchronous code that looks synchronous.',
    ),
    Question(
      category: 'Performance',
      question: 'Why does Flutter use Dart?',
      answer: 'Dart allows Flutter to compile to native ARM code for high performance. It also supports Just-In-Time (JIT) compilation for fast development cycles (Hot Reload) and Ahead-Of-Time (AOT) compilation for fast startup and execution in production.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Important Exam Questions', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
            child: const Text(
              'Review these critical questions before your exam. Tap on a question to reveal the answer.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                final q = _questions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ExpansionTile(
                    title: Text(
                      q.question,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        q.category,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary, 
                          fontSize: 12, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          q.answer,
                          style: const TextStyle(fontSize: 15, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
