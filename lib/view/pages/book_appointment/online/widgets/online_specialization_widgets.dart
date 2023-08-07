import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/colors.dart';

import '../../../../../utils/data/server_data.dart';
import '../../../../../utils/styles/image_style.dart';

Widget onlineSpecializationGridItemView(String imageUrl, String title){
  return InkWell(
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(2),
              bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(2)
          ),
        side: BorderSide(color: Colors.grey,width: 2)
      ),
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            //Image.network(onlineSpecializationPath+imageUrl,height: 40,width: 40,),
            //showNetworkImageWithCached(imageUrl: onlineSpecializationPath+imageUrl, height: 40, radius: 40, width: 0),
            CachedNetworkImage(imageUrl: onlineSpecializationPath+imageUrl,height: 40,width: 40,
              placeholder: (c,s){
              return imagePlaceHolderView(40, 40, 0);
              },
              errorWidget: (c,s,d){
              return imageErrorView(40, 40, 0);
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            )
          ],
        ),
      ),
    ),
  );
}

