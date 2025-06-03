import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 2),(){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=> const HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    final isDark= Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark? Colors.black : Colors.purple[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const[
            Icon(Icons.note_alt,

            size: 100,
            color: Colors.deepPurple,),
            SizedBox(height: 16,),
            Text(
                'Personal Notes',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
