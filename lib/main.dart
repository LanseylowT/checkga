import 'package:checkga/models/student.dart';
import 'package:checkga/repositories/auth_service_repository.dart';
import 'package:checkga/test_views/auth_check_screen.dart';
import 'package:checkga/viewmodels/auth_service_viewmodel.dart';
import 'package:checkga/viewmodels/student_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// TODO: Make a Login Page and a Register Page
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthServiceViewmodel(AuthServiceRepository()))
      ],
      child: MaterialApp(
        title: "CheckGA!",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        home: AuthCheckScreen(),
      ),
    );
  }
}

class MyShit extends StatelessWidget {
  const MyShit({super.key});

  @override
  Widget build(BuildContext context) {
    final studentViewModel =
        Provider.of<StudentViewmodel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Students"),
      ),
      body: StreamBuilder<List<Student>>(
        stream: studentViewModel.getStudentsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("No students found"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final student = snapshot.data![index];
              return ListTile(
                title: Text("${student.firstName} ${student.lastName}"),
                subtitle: Text("Year Level: ${student.yearLevel}"),
              );
            },
          );
        },
      ),
    );
  }
}
