import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/authentication.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
              SvgPicture.asset("assets/spotify-icon 1.svg", height: 140, width: 140,),
              const SizedBox(height: 20,),
              const Text("Sclontify", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),),
              const SizedBox(height: 180,),
              const Text("Iniciar sesión", style: TextStyle(fontSize: 20, color: Colors.white),),
              const SizedBox(height: 20,),
              FutureBuilder(
                future: Authentication.initializeFirebase(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return const GoogleSignInButton();
                  }
                  return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  );
                },
              ),
              
            ],
          ),
        
      ),
    );
  }
}







class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                User? user =
                    await Authentication.signInWithGoogle(context: context);

                
                // TODO: Add a method call to the Google Sign-In authentication


                setState(() {
                  _isSigningIn = false;
                });


                if (user != null) {
                  Navigator.pushNamed(context, 'menu');
                }
              },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/google-icon.svg',
                height: 35.0,
              ),
              // Image(
              //   image: AssetImage("assets/google-icon.svg"),
              //   height: 35.0,
              // ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
             
    );
  }
}









