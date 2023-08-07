import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/Providers/CategorySubCategoryProvider.dart';
import 'package:healthcare2050/Providers/CityListProvider.dart';
import 'package:healthcare2050/Providers/history_appointment_provider.dart';
import 'package:healthcare2050/Providers/user_details_provider.dart';
import 'package:healthcare2050/firebase_options.dart';
import 'package:healthcare2050/services/appointments/offline_appointment_apis.dart';
import 'package:healthcare2050/services/appointments/online_appointment_apis.dart';
import 'package:healthcare2050/services/maps/maps_apis.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:healthcare2050/utils/get_location_data.dart';
import 'package:healthcare2050/utils/helpers/notification_helper.dart';
import 'package:healthcare2050/utils/themes/app_theme.dart';

import 'package:healthcare2050/view/pages/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(handleFirebaseBackGroundNotification);
  createNotificationChannel();
  handleForegroundNotification();

  await FirebaseAnalytics.instance;

  // var token = await NotificationScreenState().getTokenz();
  // print("---token---$token");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CategorySubCategoryProvider>.value(value: CategorySubCategoryProvider()),
        ChangeNotifierProvider<CityListProvider>.value(value: CityListProvider()),
        ChangeNotifierProvider<SlotsAppointmentProvider>.value(value: SlotsAppointmentProvider()),
        ChangeNotifierProvider<HistoryAppointmentProvider>.value(value: HistoryAppointmentProvider()),
        ChangeNotifierProvider<UserDetailsProvider>.value(value: UserDetailsProvider()),
        ChangeNotifierProvider<GetCurrentLocationDataProvider>.value(value: GetCurrentLocationDataProvider()),
        ChangeNotifierProvider<OnlineAvailableSlotProvider>.value(value: OnlineAvailableSlotProvider()),
        ChangeNotifierProvider<MarkerOnMapProvider>.value(value: MarkerOnMapProvider()),
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Sizer(builder: (c,o,dt){
      return _removeScrollGlow(
          MaterialApp(
            initialRoute: '/',
            debugShowCheckedModeBanner: false,
            title: '2050 Healthcare',
            theme: appTheme(),
            home: SplashScreen(),
          )
      );
    });
  }

  _removeScrollGlow(Widget child){
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child:child
    );
  }
}

