import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/view/pages/landing/landing_screen.dart';
import 'package:healthcare2050/view/pages/voice_call/widgets/audio_users_view.dart';
import 'package:healthcare2050/view/pages/voice_call/widgets/show_call_timer.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wakelock/wakelock.dart';
import '../../../utils/colors.dart';
import '../../../utils/settings.dart';

class AudioCallScreen extends StatefulWidget {
  final String channelName;

  const AudioCallScreen({Key? key, required this.channelName}) : super(key: key);

  @override
  _AudioCallScreenState createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  late RtcEngine _engine;
  final Map<int, AudioUserModel> _userMap = <int, AudioUserModel>{};
  bool _muted = false;
  int? _localUid;
  bool speakerMuted = true;
  bool otherJoined = false;

  @override
  void dispose() {
    _userMap.clear();
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
    Wakelock.disable();
  }

  @override
  void initState() {
    super.initState();
    initialize();
    Wakelock.enable();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      print("'APP_ID missing, please provide your APP_ID in settings.dart");
      return;
    }
     await _initAgoraRtcEngine();

  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableLocalVideo(false);
    await _engine.enableLocalAudio(true);
    await _engine.setChannelProfile(ChannelProfile.Communication);
    await _engine.enableAudioVolumeIndication(250, 3, true);
    await _joinChannel();
    _addAgoraEventHandlers();
  }

  _joinChannel() async {
    await _engine
        .joinChannel(Token, widget.channelName, null, 0)
        .catchError((onError) {
    });
  }

  Future<void> _addAgoraEventHandlers() async{
    _engine.setEventHandler(
      RtcEngineEventHandler(error: (code) {
        print("error occurred $code");
      }, joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          _localUid = uid;
          _userMap.addAll({uid: AudioUserModel(uid, false)});
        });
      }, leaveChannel: (stats) {
        setState(() {
          _userMap.clear();
          ShowCallTimerState().watch.stop();
          ShowCallTimerState().timer?.cancel();
        });
      },
          userJoined: (uid, elapsed) {
            setState(() {
              _userMap.addAll({uid: AudioUserModel(uid, false)});
              otherJoined = true;
            });
          }, userOffline: (uid, elapsed) {

            setState(() {
              otherJoined = true;
              ShowCallTimerState().watch.stop();
              _userMap.remove(uid);
            });
          }, audioVolumeIndication: (volumeInfo, v) {
            volumeInfo.forEach((speaker) {
              //detecting speaking person whose volume more than 5
              if (speaker.volume > 5) {
                try {
                  _userMap.forEach((key, value) {
                    if ((_localUid?.compareTo(key) == 0) && (speaker.uid == 0)) {
                      setState(() {
                        _userMap.update(key, (value) => AudioUserModel(key, true));
                      });
                    }
                    else if (key.compareTo(speaker.uid) == 0) {
                      setState(() {
                        _userMap.update(key, (value) => AudioUserModel(key, true));
                      });
                    } else {
                      setState(() {
                        _userMap.update(key, (value) => AudioUserModel(key, false));
                      });
                    }
                  });
                } catch (error) {
                  print('Error:${error.toString()}');
                }
              }
            });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text("Telephone Calling..."),
        actions: [otherJoined == true?showAudioTimerView():Container()],
      ),
      body: WillPopScope(
        onWillPop: () {
          return disConnectAudioDialog(context);
        },
        child: Stack(
          children: [_buildGridVideoView(),
            _toolbar(context)
          ],
        ),
      ),
    );
  }

  GridView _buildGridVideoView() {
    return GridView.builder(
      padding: const EdgeInsets.all(6),
      shrinkWrap: true,
      itemCount: _userMap.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: .6, crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Container(
          child: Container(
              color: Colors.white,
              child: (_userMap.entries.elementAt(index).key == _localUid)
                  ? showAudioUserView(
                "You",
              )
                  : showAudioUserView(
                "$index",
              )
          ),
          decoration: BoxDecoration(
            border: Border.all(
                color: _userMap.entries.elementAt(index).value.isSpeaking
                    ? Colors.green
                    : Colors.grey,
                width: 6),
            borderRadius: const BorderRadius.all(
              Radius.circular(6.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _toolbar(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              _muted ? Icons.mic_off : Icons.mic,
              color: _muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: _muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return RawMaterialButton(
                onPressed: () => _onCallEnd(context),
                child: const Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 35.0,
                ),
                shape: const CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.redAccent,
                padding: const EdgeInsets.all(15.0),
              );
            },

          ),
          RawMaterialButton(
            onPressed: () => _onSpeakerMute(),
            child: Icon(
              speakerMuted == false ? Icons.volume_down : Icons.volume_up,
              color: speakerMuted == false ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: speakerMuted == false ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(15.0),
          ),
        ],
      ),
    );
  }

  void _onSpeakerMute() {
    setState(() {
      speakerMuted = !speakerMuted;
    });
    _engine.setEnableSpeakerphone(speakerMuted);
  }

  void _onCallEnd(BuildContext context) {
    disConnectAudioDialog(context);
  }

  void _onToggleMute() {
    setState(() {
      _muted = !_muted;
    });
    _engine.muteLocalAudioStream(_muted);
  }

  Future<bool>disConnectAudioDialog(BuildContext context)async {
     btnStyle(Color color) => ElevatedButton.styleFrom(backgroundColor: color);
     showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            titleTextStyle: const TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
            title: const Text("Leave Audio Call!"),
            content: const Text("Do you want to leave call now?"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    finish(context);
                  },
                  child: const Text("Not Now"),style: btnStyle(Colors.grey),),
              ElevatedButton(
                onPressed: () {
                  finish(context);
                  _engine.leaveChannel();
                  Wakelock.disable();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LandingScreen()),
                          (route) => false);
                },
                child: const Text("Leave"),
                style: btnStyle(Colors.red),
              )
            ],
          );
        });
     return true;
  }
}
