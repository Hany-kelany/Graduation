import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradproject/screens/alerting.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import '../providers/play_audio_provider.dart';
import '../providers/record_audio_provider.dart';

class RecordAndPlayScreen extends StatefulWidget {
  const RecordAndPlayScreen({Key? key}) : super(key: key);

  @override
  State<RecordAndPlayScreen> createState() => _RecordAndPlayScreenState();
}

class _RecordAndPlayScreenState extends State<RecordAndPlayScreen> {
  // customizeStatusAndNavigationBar() {
  //   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //       systemNavigationBarColor: Colors.white,
  //       statusBarColor: Colors.transparent,
  //       systemNavigationBarIconBrightness: Brightness.dark,
  //       statusBarBrightness: Brightness.light));
  // }

  // @override
  // void initState() {
  //   customizeStatusAndNavigationBar();
  //   super.initState();
  //   // Timer.periodic(Duration(seconds: 3), (Timer t) async {
  //   //   _recordingSection();
  //   // });
  // }
  late Timer _timer;
  bool record=false;

  @override
  Widget build(BuildContext context) {
    final _recordProvider = Provider.of<RecordAudioProvider>(context);
    final _playProvider = Provider.of<PlayAudioProvider>(context);

    return Scaffold(
      //backgroundColor: Colors.white,
      body: Stack(

        children:[ Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color(0xff032b50),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              _recordProvider.recordedFilePath.isEmpty
                  ? _recordHeading()
                  : _playAudioHeading(),
              const SizedBox(height: 40),
              _recordProvider.recordedFilePath.isEmpty
                  ? _recordingSection()
                  : _audioPlayingSection(),
              if (_recordProvider.recordedFilePath.isNotEmpty &&
                  !_playProvider.isSongPlaying)
                const SizedBox(height: 40),
              if (_recordProvider.recordedFilePath.isNotEmpty &&
                  !_playProvider.isSongPlaying)
                _resetButton(),
            ],
          ),
        ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0,right: 16),
            child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AlertScreen(),));
                },child: Icon(Icons.settings,color:Color(0xff032b50),size: 30, ),backgroundColor: Colors.white,)),
          ),

        ]
      ),
    );
  }

  _recordHeading() {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Icon(Icons.signal_cellular_alt_rounded,color: Colors.white,),
                    Icon(Icons.signal_cellular_alt_2_bar_rounded,color: Colors.white,),

                  ],
                )),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Recording...',
                style: TextStyle(color: Colors.white,fontSize: 30),),
            ),
            SizedBox(height: 15,),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Record the sound for up to 5 ',
                style: TextStyle(color: Colors.white,fontSize: 16),),
            ),
            SizedBox(height: 5,),
            Align(
              alignment: Alignment.topLeft,
              child: Text('seconds',
                style: TextStyle(color: Colors.white,fontSize: 16),),
            ),
            SizedBox(height: 100,),

          ],
        ),
      ),

    );

  }

  _playAudioHeading() {
    return const Center(
      child: Text(
        'Play Audio',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  _recordingSection() {
    final _recordProvider = Provider.of<RecordAudioProvider>(context);
    final _recordProviderWithoutListener =
        Provider.of<RecordAudioProvider>(context, listen: false);
    if (_recordProvider.isRecording) {
      return InkWell(
        onTap: () {
          _timer.cancel();
          _recordProviderWithoutListener.stopRecording();
        },
        child: RippleAnimation(
          repeat: true,
          color:  Colors.white,
          minRadius: 40,
          ripplesCount: 6,
          child:Column(children: [
            _commonIconSection()
          ],) ,

        ),
      );
    }

    return InkWell(
      onTap: () async {
        _timer = Timer.periodic(Duration(milliseconds: 3600), (Timer t) async {
          if (!_recordProvider.isRecording) {
            await _recordProviderWithoutListener.recordVoice();
            await Future.delayed(Duration(seconds: 3));
            await _recordProviderWithoutListener.stopRecording();
            await Future.delayed(Duration(milliseconds: 500));
            await _recordProvider.clearOldData();
          }
        });

      },

      // async => await _recordProviderWithoutListener.recordVoice(),
      child: _commonIconSection(),
    );
    // });
  }

  _commonIconSection() {
    return Column(
      children:[ Container(
        width: 70,
        height: 70,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:  Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(Icons.keyboard_voice_rounded,
            color: Color(0xff032b50), size: 40),
      ),
        ]
    );
  }

  _audioPlayingSection() {
    final _recordProvider = Provider.of<RecordAudioProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width - 110,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue,
      ),
      child: Row(
        children: [
          _audioControllingSection(_recordProvider.recordedFilePath),
          _audioProgressSection(),

        ],
      ),
    );
  }

  _audioControllingSection(String songPath) {
    final _playProvider = Provider.of<PlayAudioProvider>(context);
    final _playProviderWithoutListen =
        Provider.of<PlayAudioProvider>(context, listen: false);

    return IconButton(
      onPressed: () async {
        if (songPath.isEmpty) return;
        await _playProviderWithoutListen.playAudio(File(songPath));
      },
      icon: Icon(
          _playProvider.isSongPlaying ? Icons.pause : Icons.play_arrow_rounded),
      color: const Color(0xff4BB543),
      iconSize: 30,

    );
  }

  _audioProgressSection() {
    final _playProvider = Provider.of<PlayAudioProvider>(context);

    return Expanded(
        child: Column(
          children: [
            Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: LinearPercentIndicator(
            percent: _playProvider.currLoadingStatus,
            backgroundColor: Colors.black26,
            progressColor: const Color(0xff4BB543),
      ),
    ),
          ],
        ));
  }

  _resetButton() {
    final _recordProvider =
        Provider.of<RecordAudioProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        // Timer.periodic(Duration(seconds: 3), (Timer t) async {
        _recordProvider.clearOldData();
        // });
      },
      child: Center(
        child: Column(

          children: [
            Container(
              width: 80,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Reset',
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
