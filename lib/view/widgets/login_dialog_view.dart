import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/data/local_data_keys.dart';
import 'package:healthcare2050/view/pages/auth/phone_auth_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/data/shared_preference.dart';

class ShowLoginDialogInView {
  checkLoginStatus(BuildContext context, Widget target) async {
    if (await getBoolFromLocal(loggedInKey) == true) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => target));
    } else {
      _showLoginDialog(context);
    }
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.login,
                    color: Colors.red,
                  ),
                  10.width,
                  Text("Not Registered Yet!"),

                ],
              ),
              content: Text("Please Login to get the facilities"),
              actions: [
                CupertinoDialogAction(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                CupertinoDialogAction(
                    child: Text("Login",style: TextStyle(color: textColor),),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhoneAuthScreen()),
                          (route) => false);
                    }),
              ],
            ));
  }
}
