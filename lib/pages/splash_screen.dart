import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreenPage extends StatefulWidget {
  const 
SplashScreenPage({ Key? key }) : super(key: key);
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}
class _SplashScreenPageState extends State<SplashScreenPage> {
  Timer? _delaySplash;

  @override
  void initState() {
  super.initState();
    _delaySplash = Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed('login');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _delaySplash!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/spotify-icon 1.svg", height: 140, width: 140,),
              const SizedBox(height: 20,),
              const Text("Sclontify", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),),
              
            ],
          ),
          
        ),
    );

    
  }
}


