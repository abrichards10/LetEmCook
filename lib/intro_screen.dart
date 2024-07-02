import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:let_em_cook/navigation.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _offset =
        Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSwipeUp() {
    print("Swipe up detected");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NavigationPage()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          _onSwipeUp();
        }
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Center(
              child: SlideTransition(
                position: _offset,
                child: FadeTransition(
                  opacity: _opacity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Let \'Em Cook',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.adventPro().fontFamily,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      // Text(
                      //   'The best app ever', // TODO: change
                      //   style: TextStyle(
                      //     fontSize: 24.0,
                      //     fontFamily: GoogleFonts.adventPro().fontFamily,
                      //   ),
                      // ),
                      // SizedBox(height: 50.0),
                      Icon(
                        Icons.keyboard_arrow_up,
                        size: 48.0,
                        color: Colors.grey,
                      ),
                      Text(
                        'Swipe up to continue',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontFamily: GoogleFonts.adventPro().fontFamily,
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
    );
  }
}
