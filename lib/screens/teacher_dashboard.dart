// lib/screens/teacher_dashboard.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeacherDashboard extends StatelessWidget {
  final User user;

  TeacherDashboard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Teacher Dashboard - ${user.email}')),
      body: Center(child: Text('Welcome to the Teacher Dashboard')),
    );
  }
}
