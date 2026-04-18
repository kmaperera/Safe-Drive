import 'package:flutter/material.dart';
import '../widgets/auth/auth_textfield.dart';
import '../widgets/auth/auth_button.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 30),

                /// Logo + Title
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
                        "Create Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                /// Full Name
                const Text(
                  "Full Name",
                  style: TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 8),

                const AuthTextField(
                  hint: "Enter your full name",
                  icon: Icons.person,
                ),

                const SizedBox(height: 20),

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
                  hint: "Create a password",
                  icon: Icons.lock,
                  isPassword: true,
                ),

                const SizedBox(height: 20),

                /// Confirm Password
                const Text(
                  "Confirm Password",
                  style: TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 8),

                const AuthTextField(
                  hint: "Confirm your password",
                  icon: Icons.lock,
                  isPassword: true,
                ),

                const SizedBox(height: 30),

                /// Signup Button
                AuthButton(
                  text: "Sign Up",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                const SizedBox(height: 20),

                /// Login Navigation
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}