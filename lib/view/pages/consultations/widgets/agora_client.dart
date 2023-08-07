import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../utils/settings.dart';
import '../../doctor_review/doctor_review_screen.dart';

handleAgoraClient(
    String channelName, String patientName, BuildContext context,String doctorId) {
  return AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: APP_ID,
        channelName: channelName,
        username: patientName,
      ),
      enabledPermission: [Permission.camera, Permission.accessMediaLocation],
      agoraEventHandlers: AgoraRtcEventHandlers(
        leaveChannel: (state) {
         // navigateToEndCallScreen(context,doctorId);
        },
        rejoinChannelSuccess: (s,a,c){
          Fluttertoast.showToast(msg: "Rejoin Successful");
        },
        joinChannelSuccess: (data, a, b) {
          Fluttertoast.showToast(msg: "You Join Successful");
        },
      ),
      agoraRtmClientEventHandler: AgoraRtmClientEventHandler(),
      agoraRtmChannelEventHandler: AgoraRtmChannelEventHandler(
        onMemberLeft: (member) {
          Fluttertoast.showToast(
              msg: "Doctor left",
              backgroundColor: Colors.red,
              toastLength: Toast.LENGTH_LONG);
          //navigateToEndCallScreen(context,doctorId);
        },
        onMemberJoined: (member) {
          Fluttertoast.showToast(
              msg: "Doctor join",
              backgroundColor: Colors.green,
              toastLength: Toast.LENGTH_LONG);
        },
      ),
      agoraChannelData: AgoraChannelData(
        setCameraTorchOn: true,
      ));
}

showCallLeaveDialog(BuildContext context, RtcEngine engine,String scheduleId,String doctorId) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
            title: Text('Call Leave Alert'),
            content: Text(
                "Do you really want to leave the call?"),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    LoaderDialogView(context).showLoadingDialog();
                    finish(context);
                    engine.leaveChannel();
                    Wakelock.disable();
                    Fluttertoast.showToast(msg: "Call Leaved");
                    LoaderDialogView(context).dismissLoadingDialog();
                    navigateToEndCallScreen(context,doctorId);
                  },
                  child: Text("Leave Call")),
              10.width,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    finish(context);
                  },
                  child: Text("Not Now"))
            ],
          ));
}

navigateToEndCallScreen(BuildContext context,String doctorId) {
  return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DoctorReviewScreen(doctorId: doctorId),
          fullscreenDialog: true));
}
