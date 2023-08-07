
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/view/pages/history/today_appointments/today_appointment_tab_view.dart';
import 'package:healthcare2050/view/pages/home/home_screen.dart';
import 'package:healthcare2050/view/pages/landing/widgets/landing_floating_widget.dart';
import 'package:healthcare2050/view/pages/services/all_service_screen.dart';

import '../../../constants/constants.dart';
import '../../../utils/helpers/internet_helper.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0,);
    InternetHelper(context: context).checkConnectivityRealTime(callBack: (status){});
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showAppExitDialog(context),
      child: Scaffold(
          floatingActionButton: LandingFloatingView(),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
          body: SizedBox.expand(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              padEnds: true,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: <Widget>[
                HomeScreen(),
                AllServiceScreen(),
                TodayAppointmentTabView(),
              ],
            ),


          ),
          bottomNavigationBar: BottomNavyBar(
            animationDuration: Duration(milliseconds: 500),
            backgroundColor: Colors.white,
            selectedIndex: _currentIndex,
            onItemSelected: (index) {
              setState(() => _currentIndex = index);
              _pageController.jumpToPage(index);
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                  activeColor: iconColor,
                  title: Text('Home'),
                  icon: Icon(Icons.home_outlined,color: themColor,)
              ),
              BottomNavyBarItem(
                  activeColor: iconColor,
                  title: Text('Services'),
                  icon: Icon(Icons.medical_services_outlined,color: themColor,)
              ),
              BottomNavyBarItem(
                  activeColor: iconColor,
                  title: Text('Appointments'),
                  icon: Icon(CupertinoIcons.doc_text,color: themColor,)
              ),
              BottomNavyBarItem(
                activeColor: Colors.white,
                title: Text(''),
                icon: Icon(Icons.more_vert,color: Colors.white),
              ),
            ],
          )

      ),
    );
  }

}
