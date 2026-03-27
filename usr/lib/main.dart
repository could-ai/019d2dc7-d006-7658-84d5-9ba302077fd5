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
  final int marks;

  Question({
    required this.question,
    required this.answer,
    required this.marks,
  });
}

class ExamQuestionsScreen extends StatefulWidget {
  const ExamQuestionsScreen({super.key});

  @override
  State<ExamQuestionsScreen> createState() => _ExamQuestionsScreenState();
}

class _ExamQuestionsScreenState extends State<ExamQuestionsScreen> {
  // A categorized list of important mock exam questions based on marks.
  final List<Question> _allQuestions = [
    // --- 1 MARK QUESTIONS (Short / Objective) ---
    Question(
      marks: 1,
      question: 'What is Flutter?',
      answer: 'Flutter is an open-source UI software development kit created by Google for building natively compiled applications for mobile, web, and desktop from a single codebase.',
    ),
    Question(
      marks: 1,
      question: 'Which programming language is used for Flutter development?',
      answer: 'Dart.',
    ),
    Question(
      marks: 1,
      question: 'What is a Widget in Flutter?',
      answer: 'In Flutter, everything is a widget. Widgets are the basic building blocks of a Flutter app\'s user interface, describing what their view should look like given their current configuration and state.',
    ),
    Question(
      marks: 1,
      question: 'What is the command to create a new Flutter project?',
      answer: 'flutter create <project_name>',
    ),

    // --- 2 MARKS QUESTIONS (Brief Explanation) ---
    Question(
      marks: 2,
      question: 'What is the difference between Hot Reload and Hot Restart?',
      answer: 'Hot Reload injects updated source code files into the running Dart Virtual Machine (VM) while preserving the app\'s state, making it very fast. Hot Restart resets the state to the app\'s initial state and completely recompiles the code, taking slightly longer.',
    ),
    Question(
      marks: 2,
      question: 'Explain the purpose of the pubspec.yaml file.',
      answer: 'The pubspec.yaml file is the project configuration file in Flutter. It is used to define project metadata, manage dependencies (third-party packages), and declare assets like images and custom fonts.',
    ),
    Question(
      marks: 2,
      question: 'What is the difference between "var" and "dynamic" in Dart?',
      answer: '"var" infers the variable type at compile-time and locks it (you cannot assign a string to it later if it was initialized as an int). "dynamic" disables type checking, allowing the variable\'s type to change at runtime.',
    ),
    Question(
      marks: 2,
      question: 'What is a BuildContext?',
      answer: 'BuildContext is a locator that identifies a widget\'s exact position in the widget tree. It is essential for looking up inherited widgets, themes, media queries, and handling navigation routing.',
    ),

    // --- 5 MARKS QUESTIONS (Detailed / Long Answer) ---
    Question(
      marks: 5,
      question: 'Explain the difference between StatelessWidget and StatefulWidget in detail with use cases.',
      answer: '1. StatelessWidget: These are immutable widgets, meaning their properties cannot change once built. They are used for static content that does not depend on data changes or user interaction (e.g., Text, Icon, static Images). Their lifecycle is simple, primarily consisting of the build() method.\n\n2. StatefulWidget: These are mutable widgets that maintain state which can change over time. When the state changes, calling setState() triggers a UI rebuild. They are used when the UI needs to update dynamically based on user interaction, network responses, or animations (e.g., Checkbox, TextField, dynamic lists). Their lifecycle is more complex, including createState(), initState(), build(), and dispose().',
    ),
    Question(
      marks: 5,
      question: 'Describe the Flutter Widget Lifecycle for a StatefulWidget.',
      answer: 'The lifecycle of a StatefulWidget consists of several key stages:\n\n1. createState(): Called immediately to create the mutable state object.\n2. initState(): Called exactly once when the state object is inserted into the widget tree. Used for one-time initializations.\n3. didChangeDependencies(): Called when a dependency of the State object changes (e.g., InheritedWidget updates).\n4. build(): Describes the user interface. It is called frequently whenever the UI needs to render.\n5. didUpdateWidget(): Called whenever the parent widget changes and needs to rebuild this widget with a new configuration.\n6. setState(): A method called by the developer to notify the framework that internal state has changed, triggering a build().\n7. deactivate(): Called when the state object is temporarily removed from the tree.\n8. dispose(): Called when the state object is permanently removed. Used for cleanup (e.g., canceling timers, disposing controllers).',
    ),
    Question(
      marks: 5,
      question: 'Explain how asynchronous programming works in Dart.',
      answer: 'Dart is a single-threaded language, but it handles asynchronous operations smoothly using the Event Loop, Futures, and Streams.\n\n1. Futures: Represent a potential value or error that will be available at some time in the future. They are used for single asynchronous operations like fetching data from a network or reading a file.\n2. async / await: These keywords provide a declarative way to write asynchronous code that looks and behaves like synchronous code, making it easier to read and maintain.\n3. Streams: Represent a sequence of asynchronous events over time. They are used for continuous data flow, like listening to location updates or real-time database changes. You can listen to a stream and react every time a new piece of data arrives.',
    ),
  ];

  List<Question> _getQuestionsByMarks(int marks) {
    return _allQuestions.where((q) => q.marks == marks).toList();
  }

  Widget _buildQuestionList(int marks) {
    final questions = _getQuestionsByMarks(marks);
    
    if (questions.isEmpty) {
      return const Center(child: Text('No questions available for this category.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final q = questions[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ExpansionTile(
            title: Text(
              q.question,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                '${q.marks}m',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Important Exam Questions', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: '1 Mark', icon: Icon(Icons.looks_one)),
              Tab(text: '2 Marks', icon: Icon(Icons.looks_two)),
              Tab(text: '5 Marks', icon: Icon(Icons.looks_5)),
            ],
            indicatorWeight: 3,
          ),
        ),
        body: TabBarView(
          children: [
            _buildQuestionList(1),
            _buildQuestionList(2),
            _buildQuestionList(5),
          ],
        ),
      ),
    );
  }
}
