import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/our_presence/zone_by_state_model.dart';
import 'package:healthcare2050/services/our_presencec/our_presence_apis.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/view/pages/searches/search_city_details_screen.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../Model/our_presence/state_by_city_model.dart';

class OurPresenceStateView extends StatelessWidget {
  final String zoneId;
  final String zoneName;

  const OurPresenceStateView(
      {Key? key, required this.zoneId, required this.zoneName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zone Name"),
      ),
      body: FutureBuilder(
        future: OurPresenceApis().getStateDataByZone(zoneId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<ZoneByStateModel> data = snapshot.data;
            return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _showCityBottomSheet(
                          context,
                          data[index].stateName ?? "No Data",
                          data[index].id.toString());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data[index].stateName ?? "Not Available",
                          style: boldTextStyle(color: textColor),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: iconColor,
                            ))
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, i) {
                  return Divider(
                    color: iconColor,
                    height: 1,
                  );
                },
                itemCount: data.length);
          } else {
            return ScreenLoadingView();
          }
        },
      ),
    );
  }

  _showCityBottomSheet(BuildContext context, String stateName, String cityId) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        )),
        context: context,
        builder: (context) => _cityView(stateName, context, cityId));
  }

  _cityView(String stateName, BuildContext context, String cityId) {
    return Column(
      children: [
        10.height,
        Text(
          stateName,
          style: boldTextStyle(color: textColor, size: 20),
        ),
        5.height,
        Divider(
          color: iconColor,
          thickness: 2,
        ),
        Expanded(
            child: FutureBuilder(
          future: OurPresenceApis().getStateWiseCityList(cityId),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              List<StateByCityModel> data = snapshot.data;
              return data.isNotEmpty?ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        finish(context);
                        SearchCityDetailsScreen(
                          cityName: data[index].cityName ?? "Not Available",
                          cityId: data[index].id.toString(),
                        ).launch(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data[index].cityName ?? "Not Available",
                            style: boldTextStyle(color: textColor),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.keyboard_arrow_right,
                                color: iconColor,
                              ))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, i) {
                    return Divider(
                      color: iconColor,
                      height: 1,
                    );
                  },
                  itemCount: data.length):_noCityAvailableView();
            } else {
              return ScreenLoadingView();
            }
          },
        ))
      ],
    );
  }

  _noCityAvailableView(){
    return Center(
      child: Text("No data found"),
    );
  }
}
