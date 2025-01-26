import 'package:checkga/main.dart';
import 'package:checkga/models/app_user.dart';
import 'package:checkga/viewmodels/auth_service_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheckScreen extends StatelessWidget {
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
                UserRole? userRole = snapshot.data as UserRole?;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scanner Page")),
      body: Center(child: Text("Welcome to the Scanner Page")),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(child: Text("Please log in")),
    );
  }
}
