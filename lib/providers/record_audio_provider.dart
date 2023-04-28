import 'dart:async';

import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../services/permission_management.dart';
import '../services/storage_management.dart';
import '../services/toast_services.dart';

class RecordAudioProvider extends ChangeNotifier {
  final Record _record = Record();
  bool _isRecording = false;
  String _afterRecordingFilePath = '';

  bool get isRecording => _isRecording;
  // void set isRecording(itfalse) => _isRecording = itfalse;
  String get recordedFilePath => _afterRecordingFilePath;

  clearOldData() {
    _afterRecordingFilePath = '';
    showToast('Reset',);
    Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //SizedBox(height: 110,),
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
            child: Text('Record the sound for up to 10 ',
              style: TextStyle(color: Colors.white,fontSize: 16),),
          ),
          SizedBox(height: 5,),
          Align(
            alignment: Alignment.topLeft,
            child: Text('seconds',
              style: TextStyle(color: Colors.white,fontSize: 16),),
          ),
          SizedBox(height: 120,)
        ],
      ),
    );
    notifyListeners();
  }

  recordVoice() async {
    final _isPermitted = (await PermissionManagement.recordingPermission()) &&
        (await PermissionManagement.storagePermission());

    if (!_isPermitted) return;

    if (!(await _record.hasPermission())) return;

    final _voiceDirPath = await StorageManagement.getAudioDir;
    final _voiceFilePath = StorageManagement.createRecordAudioPath(
        dirPath: _voiceDirPath, fileName: 'audio_message');
    await _record.start(path: _voiceFilePath);
    _isRecording = true;
    notifyListeners();
    showToast('Recording Started');
  }

  stopRecording() async {
    String? _audioFilePath;

    if (await _record.isRecording()) {
      _audioFilePath = await _record.stop();
      showToast('Recording Stopped');
    }

    print('Audio file path: $_audioFilePath');

    _isRecording = false;
    _afterRecordingFilePath = _audioFilePath ?? '';
    notifyListeners();
  }
}
