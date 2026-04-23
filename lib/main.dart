import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/login_screen.dart';
import 'package:todos/register_page.dart';
import 'package:todos/todo_home.dart';
import 'package:todos/todo_model.dart';
import 'package:todos/todo_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main () async {
   WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(
    child: MyApp()));
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context)=>RegisterPage(),
        '/home' : (context)=>TodoHome()
      },
      theme: ThemeData(
        textTheme: TextTheme(
          displayMedium: TextStyle(color: Colors.white, fontSize: 18),
          displaySmall: TextStyle(color: Colors.white, fontSize: 14)

        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 1, 13, 33),
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        )
      ),
      // home: LoginScreen()
    );
  }
}

