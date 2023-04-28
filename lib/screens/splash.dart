import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/screens/record_and_play_audio.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   void initState() {
     // // TODO: implement initState
     // Future.delayed(Duration(seconds: 3), () {
     //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
     //     return RecordAndPlayScreen();
     //   }));
     //  });
   }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body:AnimatedSplashScreen(
          duration: 3000,
          splash: Image.asset('assets/images/logo.jpg',width: 900,height: 500),
          nextScreen: RecordAndPlayScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.white,
        splashIconSize: 180,
      ),



      // Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     AnimatedSize(
      //         duration: Duration(milliseconds: 300),
      //         curve: Curves.bounceInOut,
      //         child: Center(
      //             child: Image.asset(
      //           'assets/images/logo.jpg',
      //           width: 200,
      //           height: 150,
      //         ))),
      //   ],
      // ),
    );
  }
}
