import 'package:flutter/material.dart';

tabBarView(List<Widget> tabs) {
  return TabBar(
    indicatorSize: TabBarIndicatorSize.tab,
    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    indicatorColor: Colors.grey,
    labelColor: Colors.white,
      labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white,width: 1),
        // color: Colors.red
      ),
      tabs: tabs);
}
