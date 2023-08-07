import 'package:flutter/material.dart';
import 'package:healthcare2050/Providers/user_details_provider.dart';
import 'package:healthcare2050/utils/constants/basic_strings.dart';
import 'package:healthcare2050/view/pages/book_appointment/offline/offline_appointment_screen.dart';
import 'package:healthcare2050/view/pages/book_appointment/online/online_specialization_screen.dart';
import 'package:healthcare2050/view/pages/descriptions/app_description_screen.dart';
import 'package:healthcare2050/view/pages/home/widgets/home_shimmer_screen.dart';
import 'package:healthcare2050/view/pages/home/widgets/home_widgets.dart';
import 'package:location/location.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:provider/provider.dart';

import '../../../Providers/CategorySubCategoryProvider.dart';
import '../../../utils/helpers/internet_helper.dart';
import '../../widgets/side_drawer_widget.dart';
import '../100ms/start_video_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoadingCategory = false;

  LocationData? currentLocation;
  String address = "Your Location";

  @override
  void initState() {
    super.initState();

    final data =
        Provider.of<CategorySubCategoryProvider>(context, listen: false);
    data.fetchCategory();
    data.getServiceCategory();
    var userData = Provider.of<UserDetailsProvider>(context, listen: false);
    userData.getUserDetails();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CategorySubCategoryProvider>(context);

    // var guestToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2Nlc3Nfa2V5IjoiNjNmNzE3ODY2N2RjZjgwM2JkYjYzMmQ3Iiwicm9vbV9pZCI6IjY0MDZjMmM1ZGE3ZTdjYTgxMjg0MGVhYiIsInVzZXJfaWQiOiJxdWdqcHJ2ciIsInJvbGUiOiJndWVzdCIsImp0aSI6IjQxMGIyNWIwLTIxNDAtNGY4Ni05Y2QwLTNiZmJkYzdjOGY2NiIsInR5cGUiOiJhcHAiLCJ2ZXJzaW9uIjoyLCJleHAiOjE2Nzg4NTkzNzF9.wy0H8GeTLh_tbI9CBhnkwLtp0COj7OHP_7jumpeVdb4";

    // var hostToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2Nlc3Nfa2V5IjoiNjNmNzE3ODY2N2RjZjgwM2JkYjYzMmQ3Iiwicm9vbV9pZCI6IjY0MDZjMmM1ZGE3ZTdjYTgxMjg0MGVhYiIsInVzZXJfaWQiOiJveHNheHBmYyIsInJvbGUiOiJob3N0IiwianRpIjoiYzA3MTNjOTAtMTMxYy00YTVhLTljZjUtMTRhMWU2ZGMyYmRjIiwidHlwZSI6ImFwcCIsInZlcnNpb24iOjIsImV4cCI6MTY3ODk0MTQwNn0.3SAiFJD_CQ_QHKD4Zon5Nh2rzLHj-iGwndIax4c2atM';
    var nurseToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2Nlc3Nfa2V5IjoiNjNmNzE3ODY2N2RjZjgwM2JkYjYzMmQ3Iiwicm9vbV9pZCI6IjY0MDZjMmM1ZGE3ZTdjYTgxMjg0MGVhYiIsInVzZXJfaWQiOiJncmZhdGlzcCIsInJvbGUiOiJudXJzZSIsImp0aSI6ImRjNmMxNzY0LWZlY2MtNGMyNy1hNzEzLWM4M2ZkOTRmNWQyNiIsInR5cGUiOiJhcHAiLCJ2ZXJzaW9uIjoyLCJleHAiOjE2Nzg5NDk0NzN9.3GhHpNqnyzebOqr8RkPgdpN6Y2XHuCcRUbaBW_k_JpQ';

    String name = "Ansar Ali";

    return Scaffold(
        appBar: AppBar(
          title: Text(appName),
          actions: [
            IconButton(
              onPressed: () {
                startVideoService(context,userName: name, meetingToken: nurseToken);
                //NotificationScreen().launch(context);
              },
              icon: Icon(
                Icons.video_call_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        drawer: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: SideDrawer()),
        body: data.isloading == true ? HomeShimmerScreen() : buildBodyView()
        //body: HomeShimmerScreen(),
        );
  }

  buildBodyView() {
    double height = MediaQuery.of(context).size.height;
    return ListView(
       physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        SizedBox(
          height: height * .25,
          child: homeHeaderView(context).onTap(() {
            AppDescriptionScreen().launch(context,
                pageRouteAnimation: PageRouteAnimation.Fade,
                duration: Duration(seconds: 1));
          }),
        ),
        5.height,
        GridView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            homeConsultationView(
                context,
                OnlineSpecializationScreen(),
                Colors.blueGrey,
                "Online Consultation",
                "Book appointment for  online video and audio calls.",
                "assets/images/videoconsult.png"),
            homeConsultationView(
                context,
                OfflineAppointmentScreen(),
                Colors.grey,
                "Offline Consultation",
                "Book offline appointment here.",
                "assets/images/finddoctor.png"),
          ],
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
          childAspectRatio: .73,
        )),
        5.height,
        buildServiceView(context),
      ],
    );
  }
}
