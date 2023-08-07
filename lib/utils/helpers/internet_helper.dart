import 'package:flutter/material.dart';
import 'package:healthcare2050/view/pages/internet/internet_connection_screen.dart';
import 'package:nb_utils/nb_utils.dart';


class InternetHelper  extends ChangeNotifier{

  BuildContext context;

  InternetHelper({required this.context});
  bool showNoInternetView = false;

  Future<void> checkConnectivityRealTime({required Function(bool status) callBack}) async {
    final _connectivity = Connectivity();
      _connectivity.onConnectivityChanged.listen((result){
      if (result == ConnectivityResult.none) {
        _internetNotAvailableView();
        showNoInternetView = true;
        notifyListeners();
      } else if (result == ConnectivityResult.wifi) {
        finish(context);
        callBack(true);
        showNoInternetView = false;
        notifyListeners();
      } else if (result == ConnectivityResult.mobile) {
        finish(context);
        callBack(true);
        showNoInternetView = false;
        notifyListeners();
      } else {
        _internetNotAvailableView();
        showNoInternetView = true;
        notifyListeners();
      }
    });
  }

  Future<bool> checkConnectivity() async {
    final _connectivity = Connectivity();
    var connectionResult = await _connectivity.checkConnectivity();
    if (connectionResult == ConnectivityResult.none) {
      _internetNotAvailableView();
      return false;
    } else if (connectionResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectionResult == ConnectivityResult.mobile) {
      return true;
    } else {
      // _internetNotAvailableView();
      return false;
    }
  }

  _internetNotAvailableView() {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            InternetConnectionScreen()));
  }
}

