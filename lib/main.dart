import 'package:chatroom_chatbot/presentation/view/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
      ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFFA5353), // Airtel red color for the app bar background
        scaffoldBackgroundColor: Color(0xFFF4F4F4),
        useMaterial3: true
      ),
      home: HomeScreen(),
    );
  }
}
