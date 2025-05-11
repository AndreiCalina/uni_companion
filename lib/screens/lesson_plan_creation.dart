import 'package:flutter/material.dart';
import 'package:uni_companion/services/ai_lesson_plan_generator.dart'; // Import the AI service

class LessonPlanCreationScreen extends StatefulWidget {
  @override
  _LessonPlanCreationScreenState createState() => _LessonPlanCreationScreenState();
}

class _LessonPlanCreationScreenState extends State<LessonPlanCreationScreen> {
  final _subjectController = TextEditingController();
  final _topicsController = TextEditingController();
  final _outcomesController = TextEditingController();
  bool _isLoading = false;

  final AILessonPlanGenerator _aiGenerator = AILessonPlanGenerator();

  // Generate lesson plan using AI service
  Future<void> _generateLessonPlan() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Call Groq AI service to generate lesson plan
      String lessonPlan = await _aiGenerator.generateLessonPlan(
        subject: _subjectController.text,
        topics: _topicsController.text,
        outcomes: _outcomesController.text,
      );

      setState(() {
        _isLoading = false;
      });

      // Show the generated lesson plan in a dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Generated Lesson Plan'),
            content: Text(lessonPlan),  // Display the AI-generated lesson plan
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Show error message if AI generation fails
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to generate lesson plan: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Lesson Plan")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Subject:', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(hintText: 'e.g., Object-Oriented Design'),
            ),
            SizedBox(height: 20),
            Text('Lesson Topics:', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _topicsController,
              decoration: InputDecoration(hintText: 'e.g., Introduction to OOP'),
            ),
            SizedBox(height: 20),
            Text('Learning Outcomes:', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _outcomesController,
              decoration: InputDecoration(hintText: 'e.g., Understand OOP concepts'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: _generateLessonPlan,
              child: Text("Generate Lesson Plan"),
            ),
          ],
        ),
      ),
    );
  }
}
