import 'dart:convert';
import 'package:http/http.dart' as http;

class AILessonPlanGenerator {
  final String _apiKey = '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';
  // Replace with your Groq API key

  // Generate lesson plan using Groq AI (Llama 3.3 model)
  Future<String> generateLessonPlan({
    required String subject,
    required String topics,
    required String outcomes,
  }) async {
    try {
      // Groq API endpoint for generating chat completions
      final apiUrl = "https://api.groq.com/openai/v1/chat/completions";

      // Prepare the request data
      final data = {
        'model': 'llama-3.1-8b-instant',  // Use the model provided by Groq
        'messages': [
          {
            'role': 'user',
            'content': '''
Create a detailed lesson plan for the subject: $subject.
Topics to cover: $topics
Learning outcomes: $outcomes
Please provide a structured lesson plan with objectives, key points to cover, activities, and assessment methods.
            '''
          }
        ]
      };

      // Send the POST request to the API
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey', // API key for authentication
        },
        body: json.encode(data),
      );

      // Handle the response
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        // Extract the generated lesson plan
        return responseData['choices'][0]['message']['content'];
      } else {
        throw Exception('Failed to generate lesson plan');
      }
    } catch (e) {
      throw Exception('Error generating lesson plan: $e');
    }
  }
}
