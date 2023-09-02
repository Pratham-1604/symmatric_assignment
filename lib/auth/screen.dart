// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'magic_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = false;
  bool isLogin = false;

  Future<void> _signup(String email, String password) async {
    const url = "http://10.0.2.2:5000/signup";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}),
      );
      if (response.statusCode == 201) {
        debugPrint("User registered successfully!");

        emailController.clear();
        passwordController.clear();

        // Optionally show a success message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User registered successfully!'),
          ),
        );
      } else {
        final responseBody = json.decode(response.body);
        debugPrint(responseBody['message']);
        // Show error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['message']),
          ),
        );
      }
    } catch (error) {
      debugPrint("Failed to connect to the backend.");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to connect to the backend.')));
    }
  }

  Future<void> _login(String email, String password) async {
    const url = "http://10.0.2.2:5000/login";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}),
      );
      if (response.statusCode == 200) {
        debugPrint("Logged in successfully!");

        emailController.clear();
        passwordController.clear();

        // Optionally show a success message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged in successfully!'),
          ),
        );
      } else {
        final responseBody = json.decode(response.body);
        debugPrint(responseBody['message']);
        // Shows error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseBody['message']),
          ),
        );
      }
    } catch (error) {
      debugPrint("Failed to connect to the backend.");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to connect to the backend.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Icon(
          Icons.arrow_back_outlined,
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height * 0.9,
          decoration: const BoxDecoration(
            color: Colors.white,
            // border: Border.all(color: Colors.black),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(width: double.infinity),
                  Image.asset(
                    'assets/main.png',
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    !isLogin ? 'Sign Up' : 'Login',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 136, 23, 60),
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.pink.shade900,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.mail_outline_rounded),
                          ),
                          Expanded(
                            child: TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Times New Roman',
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.pink.shade900,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.lock_outline),
                          ),
                          Expanded(
                            child: TextField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Times New Roman',
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                              ),
                              obscureText: !showPassword,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: Icon(
                              showPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    child: GestureDetector(
                      onTap: () {
                        final String email = emailController.text.trim();
                        final String password = passwordController.text.trim();
                        !isLogin
                            ? _signup(email, password)
                            : _login(email, password);
                      },
                      child: MagicButton(
                        text: !isLogin ? 'Sign Up' : 'Login',
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        !isLogin
                            ? 'Don\'t have an account?'
                            : 'Already have an account?',
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                      GestureDetector(
                        // style: TextButton.styleFrom(
                        //   padding: EdgeInsets.zero,
                        //   splashFactory: NoSplash.splashFactory,
                        // ),
                        onTap: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(
                          !isLogin ? ' Login  ' : ' Sign Up',
                          style: TextStyle(
                            fontFamily: 'Times New Roman',
                            color: Colors.pinkAccent[700],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'By signing up you agree to our',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      ' Terms & Conditions  ',
                      style: TextStyle(
                          fontFamily: 'Times New Roman',
                          color: Colors.pinkAccent[700],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
