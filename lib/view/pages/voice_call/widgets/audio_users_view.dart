import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/view/pages/voice_call/widgets/show_call_timer.dart';
import 'package:nb_utils/nb_utils.dart';

showAudioUserView(String title,) {
  return Center(
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
          side: BorderSide(width: 1,color: mainColor),
          ),
      child: SizedBox(
        height: 60,
        width: 60,
        child: Center(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
      ),
    ),
  );
}

showAudioTimerView(){
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
      side: BorderSide(width: 1,color: mainColor),
    ),
    child: ShowCallTimer().paddingAll(4).center(),
  ).paddingAll(5);
}

class AudioUserModel {
  int uid; //reference to user uid

  bool isSpeaking; // reference to whether the user is speaking

  AudioUserModel(this.uid, this.isSpeaking);

  @override
  String toString() {
    return 'User{uid: $uid, isSpeaking: $isSpeaking}';
  }
}