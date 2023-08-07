import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/view/pages/landing/landing_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wakelock/wakelock.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants/basic_strings.dart';

class PatientVideoCallScreen extends StatefulWidget {
  final AgoraClient client;
  const PatientVideoCallScreen({Key? key, required this.client}) : super(key: key);

  @override
  State<PatientVideoCallScreen> createState() => _PatientVideoCallScreenState();
}

class _PatientVideoCallScreenState extends State<PatientVideoCallScreen> {
  @override
  void initState() {
    super.initState();
    initAgora();
    Wakelock.enable();
  }

  @override
  void dispose() {
    super.dispose();
    Wakelock.disable();
  }

  void initAgora() async {
    await widget.client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('Video Calling...'),
        centerTitle: true,
      ),
      body: WillPopScope(child: Stack(
        children: [
          AgoraVideoViewer(
            client: widget.client,
            layoutType: Layout.floating,
            enableHostControls: true,
            videoRenderMode: VideoRenderMode.Hidden,
            floatingLayoutContainerHeight: height / 4,
            floatingLayoutContainerWidth: width / 3,
            showAVState: true,
            floatingLayoutSubViewPadding: const EdgeInsets.all(10),
            disabledVideoWidget: _disableCameraView(
                width, height), // Add this to enable host controls
          ),
          AgoraVideoButtons(
            client: widget.client,
            autoHideButtonTime: 5,
            disconnectButtonChild: _disconnectView(),
          ),
        ],
      ), onWillPop: (){
        return disConnectVideoDialog();
      }),
    );
  }

  _disconnectView() {
    return InkWell(
      onTap: () {
        disConnectVideoDialog();
      },
      child: Card(
        elevation: 5,
        color: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const SizedBox(
            height: 75,
            width: 75,
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 30,
            )),
      ),
    );
  }

  _disableCameraView(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: boxDecorationRoundedWithShadow(0, blurRadius: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/Logo/logo_png.png",
            height: height / 5,
            width: width / 4,
          ),
          Text(
            appName,
            style: TextStyle(color: textColor),
          )
        ],
      ),
    );
  }

  disConnectVideoDialog() {
     bnStyle(Color color) => ElevatedButton.styleFrom(backgroundColor: color);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            titleTextStyle: const TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
            title: const Text("Leave Video Call!"),
            content: const Text("Do you want to leave call now?"),
            actions: [
              ElevatedButton(onPressed: () {
                finish(context);
              }, child: const Text("Not Now"),style: bnStyle(Colors.grey),),
              ElevatedButton(onPressed: () {
                finish(context);
                Wakelock.disable();
                widget.client.engine.leaveChannel();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LandingScreen()), (route) => false);
              }, child: const Text("Leave"),style: bnStyle(Colors.red),)
            ],
          );
        });
  }
}
