import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:let_em_cook/navigation.dart';
import 'package:let_em_cook/signup_page.dart'; // Import the SignUpPage

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoggedIn = false;
  String _welcomeMessage = '';

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
  }

  void _login() {
    setState(() {
      _isLoggedIn = true;
      _welcomeMessage =
          'Successfully logged in! Welcome, ${_usernameController.text}';
    });

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              NavigationPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }

  void _signup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _animationController.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.adventPro().fontFamily,
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(149, 51, 109, 62)),
                    ),
                    labelStyle:
                        TextStyle(color: Color.fromARGB(149, 51, 109, 62)),
                  ),
                  cursorColor: Color.fromARGB(149, 51, 109, 62),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(149, 51, 109, 62)),
                    ),
                    labelStyle:
                        TextStyle(color: Color.fromARGB(149, 51, 109, 62)),
                  ),
                  cursorColor: Color.fromARGB(149, 51, 109, 62),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(149, 51, 109, 62),
                        backgroundColor: Colors.white,
                        elevation: 5,
                        shadowColor: Color.fromARGB(149, 51, 109, 62),
                      ).copyWith(
                        shadowColor: MaterialStateProperty.all(
                          Color.fromARGB(149, 51, 109, 62),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Color.fromARGB(149, 51, 109, 62),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _signup,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(149, 51, 109, 62),
                        backgroundColor: Colors.white,
                        elevation: 5,
                        shadowColor: Color.fromARGB(149, 51, 109, 62),
                      ).copyWith(
                        shadowColor: MaterialStateProperty.all(
                          Color.fromARGB(149, 51, 109, 62),
                        ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color.fromARGB(149, 51, 109, 62),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_isLoggedIn)
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: FadeTransition(
                        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
                          CurvedAnimation(
                            parent: _animationController
                              ..forward(), // Use the animation controller
                            curve: Curves.easeIn,
                          ),
                        ),
                        child: Text(
                          _welcomeMessage,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.adventPro().fontFamily,
                          ),
                        ),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
