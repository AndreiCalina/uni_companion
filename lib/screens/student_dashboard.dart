// lib/screens/student_dashboard.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentDashboard extends StatelessWidget {
  final User user;

  StudentDashboard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Dashboard - ${user.email}')),
      body: Center(child: Text('Welcome to the Student Dashboard')),
    );
  }
}
