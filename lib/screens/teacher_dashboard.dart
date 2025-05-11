import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'lesson_plan_creation.dart'; // Import the Lesson Plan Creation screen

class TeacherDashboard extends StatelessWidget {
  final User user;

  TeacherDashboard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Dashboard - ${user.email}'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut(); // Sign out functionality
              Navigator.pushReplacementNamed(context, '/login'); // Assuming you have a login screen route
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, ${user.email}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Lesson Plan Creation screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LessonPlanCreationScreen()),
                );
              },
              child: Text("Create Lesson Plan"),
            ),
          ],
        ),
      ),
    );
  }
}
