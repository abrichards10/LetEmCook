import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isSignedUp = false;
  String _welcomeMessage = '';

  void _signup() {
    setState(
      () {
        _isSignedUp = true;
        _welcomeMessage =
            'Successfully signed up! Welcome, ${_usernameController.text}';
      },
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
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
                  'Sign Up',
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color.fromARGB(149, 51, 109, 62),
                          backgroundColor: Colors.white,
                          elevation: 5,
                          shadowColor: Color.fromARGB(149, 51, 109, 62),
                        ).copyWith(
                          shadowColor: WidgetStateProperty.all(
                            Color.fromARGB(149, 51, 109, 62),
                          ),
                        ),
                        child: Text(
                          '<- Back',
                          style: TextStyle(
                            color: Color.fromARGB(149, 51, 109, 62),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: _signup,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color.fromARGB(149, 51, 109, 62),
                          backgroundColor: Colors.white,
                          elevation: 5,
                          shadowColor: Color.fromARGB(149, 51, 109, 62),
                        ).copyWith(
                          shadowColor: WidgetStateProperty.all(
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
                    ),
                  ],
                ),
                if (_isSignedUp)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: FadeTransition(
                      opacity: Tween<double>(begin: 1.0, end: 0.0)
                          .animate(CurvedAnimation(
                        parent: AnimationController(
                          duration: Duration(seconds: 2),
                          vsync: this,
                        )..forward(),
                        curve: Curves.easeIn,
                      )),
                      child: Text(
                        _welcomeMessage,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.adventPro().fontFamily,
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
