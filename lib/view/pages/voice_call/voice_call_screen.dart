import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthcare2050/utils/styles/image_style.dart';
import 'package:healthcare2050/view/pages/consultations/widgets/agora_client.dart';
import 'package:healthcare2050/view/pages/voice_call/widgets/show_call_timer.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Model/history/today_appointment_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/helpers/internet_helper.dart';
import '../../../utils/settings.dart';

class VoiceCallScreen extends StatefulWidget {
  final TodayVideoConsultModel data;
  const VoiceCallScreen(
      {Key? key, required this.data, })
      : super(key: key);

  @override
  _VoiceCallScreenState createState() => _VoiceCallScreenState(data);
}

class _VoiceCallScreenState extends State<VoiceCallScreen>  with WidgetsBindingObserver{

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final TodayVideoConsultModel data;
  _VoiceCallScreenState(this.data);

  final _users = <int>[];
  final _infoStrings = <String>[];
  bool micMuted = true;
  bool speakerMuted = true;
  RtcEngine? _engine;
  bool hasDoctorJoined = false;
  String callState = "Waiting...";


  @override
  void dispose() {
    _users.clear();
     _engine?.muteLocalAudioStream(true);
    _engine!.leaveChannel();
    _engine!.destroy();
    flutterLocalNotificationsPlugin.cancelAll();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    initLocalNotification();

    getPermission();
    initialize();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    super.didChangeAppLifecycleState(state);
    print("---appState--${state.name}");
    switch (state) {
      case AppLifecycleState.paused:
        _showProgressNotification();
      //App is running in the background
        break;
      case AppLifecycleState.resumed:
      //App is being used again
      _engine!.enableLocalVideo(true);
        break;
      case AppLifecycleState.inactive:
        _showProgressNotification();
        break;
      case AppLifecycleState.detached:
        
        _engine!.enableLocalAudio(false);
        _engine!.disableAudio();
        _engine!.leaveChannel();

        flutterLocalNotificationsPlugin.cancelAll();
        WidgetsBinding.instance.removeObserver(this);
        break;
    }
  }

  Future<void> _showProgressNotification() async {

    _engine!.enableLocalAudio(false);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('progress channel', 'progress channel',
      channelDescription: 'progress channel description',
      channelShowBadge: false,
      importance: Importance.max,
      priority: Priority.high,
      onlyAlertOnce: true,
      autoCancel: false,
    );

    final DarwinNotificationDetails iosPlatformChannelSpecifics = DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
    );
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iosPlatformChannelSpecifics,);
    await flutterLocalNotificationsPlugin.show(
      0,
      "Consultation Going....",
      'Currently you are on consultation.',
      platformChannelSpecifics,
    );
  }

  void getPermission() async {
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await _engine!.joinChannel(
      Token,
      widget.data.channelName??"0",
      null,
      0,
    );
  }

  // Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine?.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine?.setAudioProfile(AudioProfile.Default, AudioScenario.GameStreaming);
    await _engine?.disableVideo();
    await _engine?.enableAudio();
    await _engine?.muteLocalAudioStream(true);
    await _engine?.isSpeakerphoneEnabled();
    await _engine?.setClientRole(ClientRole.Broadcaster);
  }

  // Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine?.setEventHandler(
      RtcEngineEventHandler(
        error: (code) {
          setState(() {
            final info = 'onError: $code';
            _infoStrings.add(info);
          });
        },
        joinChannelSuccess: (channel, uid, elapsed) {
          setState(() {
            final info = 'onJoinChannel: $channel, uid: $uid';
            _infoStrings.add(info);
          });
          Fluttertoast.showToast(msg: "Channel joined successfully");
        },
        leaveChannel: (stats) {
          setState(() {
            _infoStrings.add('onLeaveChannel');
            _users.clear();
            stats.duration;
            Fluttertoast.showToast(msg: "Channel leaved");
          });
        },
        userJoined: (uid, elapsed) {
          setState(() {
            final info = 'userJoined: $uid';
            _infoStrings.add(info);
            callState = "Calling";
            _users.add(uid);
            hasDoctorJoined = true;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Other joined channel"),backgroundColor: Colors.green,));
          });
        },
        userOffline: (uid, elapsed) {
          setState(() {
            final info = 'userOffline: $uid';
            _infoStrings.add(info);
            _users.remove(uid);
            ShowCallTimerState().watch.stop();
            ShowCallTimerState().timer?.cancel();
            Fluttertoast.showToast(msg: "Call Ended");
          
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voice Calling"),
      ),
      body: WillPopScope(child: Stack(
        children: [
          _doctorView(),
          _toolbar(widget.data.doctorId.toString()),
        ],
      ), onWillPop: ()=>showCallLeaveDialog(context, _engine!, "",data.doctorId.toString())),
    );
  }

  _doctorView() {
    var image =
        "https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?w=2000";
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          20.height,
          Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                  side: BorderSide(width: 1, color: iconColor)),
              child: showNetworkImageWithCached(
                  imageUrl: image, height: 90, width: 90, radius: 45)),
          5.height,
          Text(
            data.doctorName??"Not Available",
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          2.height,
          hasDoctorJoined == true
              ? ShowCallTimer()
              : Text('00:00:00', style: TextStyle(fontSize: 14)),
          2.height,
          Text(
            callState,
            style: TextStyle(
                color: hasDoctorJoined == true ? Colors.green : Colors.black),
          )
        ],
      ),
    );
  }

  Widget _toolbar(String doctorId) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              micMuted == false ?Icons.mic: Icons.mic_off,
              color: micMuted == false ? Colors.blueAccent:Colors.white ,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: micMuted == false ?Colors.white: Colors.blueAccent,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: (){
              flutterLocalNotificationsPlugin.cancelAll;
              showCallLeaveDialog(context, _engine!, "",doctorId);
            },
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: () => _onSpeakerMute(),
            child: Icon(
              speakerMuted == false ? Icons.volume_down : Icons.volume_up,
              color: speakerMuted == false ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: speakerMuted == false ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(15.0),
          ),
        ],
      ),
    );
  }

  void _onToggleMute() {
    setState(() {
      micMuted = !micMuted;
    });
    _engine?.muteLocalAudioStream(micMuted);
  }

  void _onSpeakerMute() {
    setState(() {
      speakerMuted = !speakerMuted;
    });
    _engine?.setEnableSpeakerphone(speakerMuted);
  }

  initLocalNotification(){
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(
        defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,);
  }

  void onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title??"Title"),
        content: Text(body??"body"),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SecondScreen(payload),
              //   ),
              // );
            },
          )
        ],
      ),
    );
  }
}
