import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:let_em_cook/login_page.dart';
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
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  double fontSize = 40;

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

    _slideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.0, -1.0),
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(fontSize);
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              backgroundBlendMode: BlendMode.color,
              image: DecorationImage(
                // image: AssetImage("assets/baking_background.jpg"),
                // image: AssetImage("assets/notebook_background.jpg"),
                image: AssetImage("assets/green_background.jpg"),
                fit: BoxFit.cover,
                // opacity: .8,
              ),
            ),
            child: Stack(
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
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.adventPro().fontFamily,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'I said. Let. Them.', // TODO: change
                            style: TextStyle(
                              fontSize: 24.0,
                              fontFamily: GoogleFonts.adventPro().fontFamily,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          PulseButton(onPressed: () {
                            _slideController.forward().then((_) {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      LoginPage(),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            });
                          }),
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
    );
  }
}

class PulseButton extends StatefulWidget {
  final VoidCallback onPressed;

  PulseButton({required this.onPressed});

  @override
  _PulseButtonState createState() => _PulseButtonState();
}

class _PulseButtonState extends State<PulseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 1.05).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: Text(
          'Cook.',
          style: TextStyle(
            color: const Color.fromARGB(255, 34, 78, 35),
          ),
        ),
      ),
    );
  }
}
