import 'package:flutter/material.dart';

navigateToNextPage(BuildContext context,Widget nextPage,{int duration = 2}){
  return Navigator.push(context,PageRouteBuilder(
    pageBuilder: (_, __, ___) => nextPage,
    transitionDuration: Duration(seconds: duration),
    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
  ));
}

navigateToNextPageWithRemoveUntil(BuildContext context,Widget nextPage,{int duration = 2}){
  return Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => nextPage), (route) => false);
}