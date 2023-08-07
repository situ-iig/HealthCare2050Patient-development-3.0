
import 'package:flutter/material.dart';

import '../colors.dart';
import '../sizes/border_radius.dart';
import '../sizes/default_sizes.dart';

/// return a circular border Shape
RoundedRectangleBorder circularBorderShape(
    {borderRadius = defaultBorderRadiusSize,
      Color borderColor = borderColor,
      double borderSize = defaultBorderSize}) =>
    RoundedRectangleBorder(
        borderRadius: circularBorderRadius(borderRadius: borderRadius.toDouble()),
        side: BorderSide(
          color: borderColor,
          width: borderSize,
        ));


/// return a top's left and right circular Shape
RoundedRectangleBorder topLeftRightShape(
    {borderRadius = defaultBorderRadiusSize,
      Color borderColor = borderColor,
      double borderSize = defaultBorderSize}) =>
    RoundedRectangleBorder(
        borderRadius: topLeftRightBorderRadius(borderRadius: borderRadius),
        side: BorderSide(
          color: borderColor,
          width: borderSize,
        ));

/// return a bottom's left and right circular Shape
RoundedRectangleBorder bottomLeftRightShape(
    {borderRadius = defaultBorderRadiusSize,
      Color borderColor = borderColor,
      double borderSize = defaultBorderSize}) =>
    RoundedRectangleBorder(
        borderRadius: bottomLeftRightBorderRadius(borderRadius: borderRadius),
        side: BorderSide(
          color: borderColor,
          width: borderSize,
        ));

/// return a left side's top and bottom circular Shape
RoundedRectangleBorder leftTopBottomShape(
    {borderRadius = defaultBorderRadiusSize,
      Color borderColor = borderColor,
      double borderSize = defaultBorderSize}) =>
    RoundedRectangleBorder(
        borderRadius: leftTopBottomBorderRadius(borderRadius: borderRadius),
        side: BorderSide(
          color: borderColor,
          width: borderSize,
        ));

/// return a right side's top and bottom circular Shape
RoundedRectangleBorder rightTopBottomShape(
    {borderRadius = defaultBorderRadiusSize,
      Color borderColor = borderColor,
      double borderSize = defaultBorderSize}) =>
    RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: borderRadius,topRight: borderRadius,),
        side: BorderSide(
          color: borderColor,
          width: borderSize,
        ));