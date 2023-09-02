// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> _signup(String email, String password) async {
  const url = "http://127.0.0.1:5000/signup"; // replace with your backend URL
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 201) {
      print("User registered successfully!");
    } else {
      print("Error registering user.");
    }
  } catch (error) {
    print("Failed to connect to the backend.");
  }
}
