//Package imports
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare2050/view/pages/100ms/common/util/app_color.dart';
import 'package:hmssdk_flutter/hmssdk_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

//Project imports
// import 'package:healthcare2050/view/pages/100ms/model/peer_track_node.dart';

import '../../meeting/meeting_store.dart';
import '../../model/peer_track_node.dart';

class PeerName extends StatefulWidget {
  final String userName;
  final String userRole;
  PeerName({required this.userName, required this.userRole});

  @override
  State<PeerName> createState() => _PeerNameState();
}

class _PeerNameState extends State<PeerName> {
  @override
  Widget build(BuildContext context) {
    return Selector<PeerTrackNode, Tuple2<String, bool>>(
        selector: (_, peerTrackNode) =>
            Tuple2(peerTrackNode.peer.name, peerTrackNode.peer.isLocal),
        builder: (_, data, __) {
          return Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.3),
            child: Text(
              // "${data.item2 ? "You (" : ""}${data.item1.trim()}${data.item2 ? ")" : ""}",
              "${widget.userName} (${widget.userRole})",
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  color: themeDefaultColor,
                  fontSize: 14,
                  letterSpacing: 0.25,
                  height: 20 / 14),
            ),
          );
        });
   // return nameView();
   //
   //  return nameWidget();
  }

  Widget nameWidget(){
    return Text(widget.userName);
  }

  nameView(){
    return Selector<MeetingStore,
        Tuple4<String, HMSPeer, String, String>>(
        selector: (_, meetingStore) =>
            Tuple4(
                meetingStore.filteredPeers[0].name,
                meetingStore.filteredPeers[0],
                meetingStore
                    .filteredPeers[0].role.name,
                meetingStore
                    .filteredPeers[0].metadata ??
                    ""),
        builder: (_, data, __) {
          return Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.3),
            child: Text(
              '(${data.item3.toUpperCase()}) '+data.item1,
              //"${data.item2 ? "You (" : ""}${data.item1.trim()}${data.item2 ? ")" : ""}",
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  color: themeDefaultColor,
                  fontSize: 14,
                  letterSpacing: 0.25,
                  height: 20 / 14),
            ),
          );
        });
    // return Selector<MeetingStore,
    //     Tuple4<String, HMSPeer, String, String>>(
    //   builder: ,
    // );
  }
}
