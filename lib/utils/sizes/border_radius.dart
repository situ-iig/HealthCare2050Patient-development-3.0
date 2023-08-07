import 'package:flutter/cupertino.dart';

import 'default_sizes.dart';


/// default border radius for app

defaultBorderRadius({
 double borderRadius = 1,
}) =>
    BorderRadius.circular(borderRadius);

/// return a circular border radius
BorderRadius circularBorderRadius({
  double borderRadius = defaultBorderRadiusSize,
}) =>
    BorderRadius.circular(borderRadius);

/// return a top's left and right circular border
BorderRadius topLeftRightBorderRadius({
 double borderRadius = defaultBorderRadiusSize,
}) =>
    BorderRadius.only(
      topRight: Radius.circular(borderRadius),
      topLeft: Radius.circular(borderRadius),
    );

/// return a bottom's left and right circular border
BorderRadius bottomLeftRightBorderRadius({
 double borderRadius = defaultBorderRadiusSize,
}) =>
    BorderRadius.only(
      bottomRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
    );

/// return a left side's top and bottom circular border
BorderRadius leftTopBottomBorderRadius({
 double borderRadius = defaultBorderRadiusSize,
}) =>
    BorderRadius.only(
      bottomLeft: Radius.circular(borderRadius),
      topLeft: Radius.circular(borderRadius),
    );

/// return a right side's top and bottom circular border
BorderRadius rightTopBottomBorderRadius({
 double borderRadius = defaultBorderRadiusSize,
}) =>
    BorderRadius.only(
      bottomRight: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
    );
