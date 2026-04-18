import 'package:flutter/material.dart';
import '../widgets/auth/auth_textfield.dart';
import '../widgets/auth/auth_button.dart';
import 'signup.dart';
import '../main.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center( // <-- Vertical Center
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Logo
                  Center(
                    child: Column(
                      children: const [
                        Icon(
                          Icons.directions_car,
                          color: Colors.white,
                          size: 40,
                        ),

                        SizedBox(height: 10),

                        Text(
                          "SafeDrive",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// Email
                  const Text(
                    "Email",
                    style: TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 8),

                  const AuthTextField(
                    hint: "Enter your email",
                    icon: Icons.email,
                  ),

                  const SizedBox(height: 20),

                  /// Password
                  const Text(
                    "Password",
                    style: TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 8),

                  const AuthTextField(
                    hint: "Enter your password",
                    icon: Icons.lock,
                    isPassword: true,
                  ),

                  const SizedBox(height: 10),

                  /// Forgot Password
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Login Button
                  AuthButton(
                    text: "Login",
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RootNavigationScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  /// OR Divider
                  Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "OR",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),

                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Sign Up Link
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Signup(),
                          ),
                        );
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}