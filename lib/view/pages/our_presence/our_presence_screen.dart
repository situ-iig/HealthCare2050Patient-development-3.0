import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/our_presence/our_presence_area_model.dart';
import 'package:healthcare2050/services/our_presencec/our_presence_apis.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/helpers/internet_helper.dart';
import 'widgets/our_presence_state_view.dart';

class OurPresenceScreen extends StatelessWidget {
  const OurPresenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Presence"),
      ),
      body: Center(
        child: FutureBuilder(
          future: OurPresenceApis().getOurPresenceArea(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              List<OurPresenceData> data = snapshot.data;
              return data.isNotEmpty
                  ? GridView.builder(
                    padding: EdgeInsets.all(20),
                    physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return _showAreaMapView(data[index], context);
                  })
                  : _noZoneView();
            } else if (snapshot.hasError) {
              return ErrorScreen();
            } else {
              return ScreenLoadingView();
            }
          },
        ),
      ),
    );
  }

  Widget _showAreaMapView(OurPresenceData data, BuildContext context) {
    var zoneName = data.zoneName;
    return InkWell(
      onTap: () {
        if (data.isActive == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OurPresenceStateView(
                      zoneName: zoneName ?? "No Data",
                      zoneId: data.zoneId.toString(),
                    ),
                fullscreenDialog: true),
          );
        } else {
          Fluttertoast.showToast(msg: "Sorry Not Available Now");
        }
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: boxDecorationRoundedWithShadow(12,
            backgroundColor: data.isActive == 1
                ? Colors.white
                : Colors.grey.withOpacity(.5)),
        child: Column(
          children: [
            zoneName == "East Zone"
                ? Image.asset(
                    "assets/images/east_transparent.png",
                  )
                : zoneName == "West Zone"
                    ? Image.asset(
                        "assets/images/west_transparent.png",
                      )
                    : zoneName == "North Zone"
                        ? Image.asset(
                            "assets/images/north_transparent.png",
                          )
                        : Image.asset(
                            "assets/images/south_transparent.png",
                          ),
            5.height,
            Text(
              data.zoneName ?? "Not Available",
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  _noZoneView() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Currently No Zones Available",
            style: boldTextStyle(color: textColor, size: 20),
          ),
          Text(
            "We are working on it. It will be available very soon.",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          )
        ],
      ),
    );
  }
}
