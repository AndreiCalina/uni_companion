import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';  // Import flutter_dotenv
import 'package:uni_companion/providers/auth_provider.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env file
  await dotenv.load();  // Load the .env file

  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access your API keys securely from the .env file
    String googleApiKey = dotenv.env['GOOGLE_API_KEY'] ?? 'API_KEY_NOT_FOUND';
    String groqApiKey = dotenv.env['GROQ_API_KEY'] ?? 'API_KEY_NOT_FOUND';

    print('Google API Key: $googleApiKey'); // Just for testing, remove in production
    print('Groq API Key: $groqApiKey');  // Just for testing, remove in production

    return MaterialApp(
      title: 'Uni Companion',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}
