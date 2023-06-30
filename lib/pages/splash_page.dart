import 'dart:async';

import 'package:flutter/material.dart';
import 'package:BookWise/pages/homepage.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    super.initState();
    // Menjalankan timer selama 3 detik
    Timer(Duration(seconds: 3), () {
      // Navigasi ke HomePage setelah timer selesai
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePageScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Book',
                    style: GoogleFonts.lato().copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff252525),
                    ),
                  ),
                  TextSpan(
                    text: 'Wise',
                    style: GoogleFonts.lato().copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff015DFA),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            Image.asset('images/splash_book.png'),
            const SizedBox(height: 40),
            Text(
              'Start your\nJourney with Books',
              style: GoogleFonts.lato().copyWith(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xff252525),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              'Explore the whole new world\nby reading books',
              style: GoogleFonts.lato().copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xff82868E),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
