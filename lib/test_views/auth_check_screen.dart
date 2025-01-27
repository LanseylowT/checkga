import 'package:checkga/main.dart';
import 'package:checkga/models/app_user.dart';
import 'package:checkga/viewmodels/auth_service_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:c_plugin/c_plugin.dart';

class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({super.key});

  @override
  _AuthCheckScreenState createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  @override
  Widget build(BuildContext context) {
    final authViewModel =
        Provider.of<AuthServiceViewmodel>(context, listen: false);

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> user) {
        if (user.hasData) {
          return FutureBuilder(
            future: authViewModel.getUserRole(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error Initializing Role"),
                );
              } else {
                // TODO: Replace with a role-based navigation
                UserRole? userRole = snapshot.data;
                return ScannerPage();
              }
            },
          );
        } else {
          return Login();
        }
      },
    );
  }
}

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scanner Page")),
      body: Center(child: Text("Welcome to the Scanner Page")),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
          child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                total = sum(5, 3);
              });
            },
            child: const Text("Sum"),
          ),
          const SizedBox(
            width: 16,
          ),
          Text("Sum Result: $total"),
        ],
      )),
    );
  }
}
