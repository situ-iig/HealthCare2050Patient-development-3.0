
import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

Widget servicesCityLogoView({void Function()? onTap}){
  return InkWell(
    onTap: onTap,
    child: CircleAvatar(
      backgroundColor: Colors.white,
      child: Icon(Icons.location_city,color: iconColor,),
    ),
  );
}