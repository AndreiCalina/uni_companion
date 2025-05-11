import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uni_companion/services/firestore_service.dart';
import 'teacher_dashboard.dart'; // You'll create this later
import 'student_dashboard.dart'; // You'll create this later

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String role = '';
  bool isLoading = true;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch user data (role) from Firestore
  Future<void> _fetchUserData() async {
    try {
      Map<String, dynamic> userData = await _firestoreService.getUserData(widget.user.uid);

      setState(() {
        role = userData['role'] ?? '';  // Fetch the role from the user's data
        isLoading = false;  // Stop loading once data is fetched
      });

      // Navigate based on the role
      if (role == 'teacher') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TeacherDashboard(user: widget.user)),
        );
      } else if (role == 'student') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentDashboard(user: widget.user)),
        );
      } else {
        // Handle case when the role is not found (you can show an error or redirect)
        setState(() {
          isLoading = false;
        });
        print('Error: No valid role found for the user.');
      }
    } catch (e) {
      setState(() {
        isLoading = false;  // Stop loading on error
      });
      print('Error fetching user data: $e');
      // Optionally, show an error message or redirect to a different screen
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Loading...')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home - ${widget.user.email}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${widget.user.email}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text('Role: $role', style: TextStyle(fontSize: 16)),  // Display role
          ],
        ),
      ),
    );
  }
}
