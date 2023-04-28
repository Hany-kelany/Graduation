import 'package:flutter/material.dart';
import 'package:gradproject/providers/play_audio_provider.dart';
import 'package:gradproject/providers/record_audio_provider.dart';
import 'package:gradproject/screens/alerting.dart';
import 'package:gradproject/screens/record_and_play_audio.dart';
import 'package:gradproject/screens/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecordAudioProvider()),
        ChangeNotifierProvider(create: (_) => PlayAudioProvider()),
      ],
    child: MaterialApp(
    theme: ThemeData.from(
    colorScheme: const ColorScheme.light(),
    ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    },)),
      debugShowCheckedModeBanner: false,
      home:const SplashScreen(),
      //home: RecordAndPlayScreen(),
    ));
  }
}

