import 'package:flutter/material.dart';

/// Media query for size
Size _size(BuildContext context)=> MediaQuery.of(context).size;

/// return full height of screen
double screenHeight(BuildContext context) =>_size(context).height;

/// return full height of screen
double screenWidth(BuildContext context) =>_size(context).width;


extension IntExtensions on num?{

  /// set a width with size box
  Widget get width => SizedBox(width: this?.toDouble());

  /// set a height with size box
  Widget get height => SizedBox(height: this?.toDouble(),);

}
