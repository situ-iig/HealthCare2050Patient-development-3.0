
import 'package:flutter/material.dart';
import 'package:healthcare2050/view/pages/100ms/enum/meeting_flow.dart';
import 'package:healthcare2050/view/pages/100ms/preview/preview_page.dart';
import 'package:healthcare2050/view/pages/100ms/preview/preview_store.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:provider/provider.dart';

import 'common/util/utility_function.dart';
import 'hms_sdk_interactor.dart';
import 'home_screen/screen_controller.dart';
import 'meeting/meeting_store.dart';

late PreviewStore _previewStore;
late MeetingStore _meetingStore;
late HMSSDKInteractor _hmsSDKInteractor;

void startVideoService(BuildContext context,{required String userName,required String meetingToken}) async {
  bool res = false;

  res = await Utilities.getPermissions();
  bool skipPreview =
      await Utilities.getBoolData(key: 'skip-preview') ?? false;
  bool joinWithMutedAudio =
      await Utilities.getBoolData(key: 'join-with-muted-audio') ?? true;
  bool joinWithMutedVideo =
      await Utilities.getBoolData(key: 'join-with-muted-video') ?? true;
  bool isSoftwareDecoderDisabled =
      await Utilities.getBoolData(key: 'software-decoder-disabled') ?? true;
  bool isAudioMixerDisabled =
      await Utilities.getBoolData(key: 'audio-mixer-disabled') ?? true;
  if (res) {
    await setHMSSDKInteractor(
        joinWithMutedAudio: joinWithMutedAudio,
        joinWithMutedVideo: joinWithMutedVideo,
        isSoftwareDecoderDisabled: isSoftwareDecoderDisabled,
        isAudioMixerDisabled: isAudioMixerDisabled);
    bool showStats =
        await Utilities.getBoolData(key: 'show-stats') ?? false;
    bool mirrorCamera =
        await Utilities.getBoolData(key: 'mirror-camera') ?? false;
    _meetingStore = MeetingStore(hmsSDKInteractor: _hmsSDKInteractor);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ListenableProvider.value(
          value: _meetingStore,
          child: ScreenController(
            isRoomMute: false,
            isStreamingLink: false,

            localPeerNetworkQuality: -1,
            user: userName,
            mirrorCamera: mirrorCamera,
            showStats: showStats,
            roomToken: meetingToken,
          ),
        )));

    // if (!skipPreview) {
    //   _previewStore = PreviewStore(hmsSDKInteractor: _hmsSDKInteractor);
    //   Navigator.of(context).push(MaterialPageRoute(
    //       builder: (_) => ListenableProvider.value(
    //         value: _previewStore,
    //         child: PreviewPage(
    //           roomToken: meetingToken,
    //           meetingFlow: MeetingFlow.meeting,
    //           name: fullName,
    //         ),
    //       )));
    // } else {
    //   bool showStats =
    //       await Utilities.getBoolData(key: 'show-stats') ?? false;
    //   bool mirrorCamera =
    //       await Utilities.getBoolData(key: 'mirror-camera') ?? false;
    //   _meetingStore = MeetingStore(hmsSDKInteractor: _hmsSDKInteractor);
    //   Navigator.of(context).push(MaterialPageRoute(
    //       builder: (_) => ListenableProvider.value(
    //         value: _meetingStore,
    //         child: ScreenController(
    //           isRoomMute: false,
    //           isStreamingLink: false,
    //
    //           localPeerNetworkQuality: -1,
    //           user: fullName,
    //           mirrorCamera: mirrorCamera,
    //           showStats: showStats,
    //           roomToken: meetingToken,
    //         ),
    //       )));
    // }
  }
}

Future<void> setHMSSDKInteractor(
    {required bool joinWithMutedAudio,
      required bool joinWithMutedVideo,
      required bool isSoftwareDecoderDisabled,
      required bool isAudioMixerDisabled}) async {
  HMSIOSScreenshareConfig iOSScreenshareConfig = HMSIOSScreenshareConfig(
      appGroup: "group.flutterhms",
      preferredExtension:
      "live.100ms.flutter.FlutterBroadcastUploadExtension");

  _hmsSDKInteractor = HMSSDKInteractor(
      iOSScreenshareConfig: iOSScreenshareConfig,
      joinWithMutedAudio: joinWithMutedAudio,
      joinWithMutedVideo: joinWithMutedVideo,
      isSoftwareDecoderDisabled: isSoftwareDecoderDisabled,
      isAudioMixerDisabled: isAudioMixerDisabled);
  //build call should be a blocking call
  await _hmsSDKInteractor.build();
}