
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/styles/text_field_decorations.dart';

Widget searchItemView(String title,{void Function()? onTap}){
  return ListTile(
    onTap: onTap,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight:Radius.circular(4) ,
            bottomRight: Radius.circular(4),
            topLeft: Radius.circular(40))
    ),
    trailing:  Card(
      color: Colors.white30,
      child: Icon(Icons.arrow_forward).paddingAll(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    title: Row(
      children: [
        Icon(
          Icons.location_city,
          color: Colors.white,
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.left,
            maxLines: 2,
            overflow:
            TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight:
                FontWeight.w800,
                fontSize: 16,
                color: Colors.orange),
          ),
        ),
      ],
    ),
  );
}

searchTextField(TextEditingController controller,String hint,{void Function(String)? onChanged}){
  return TextFormField(
    controller: controller,
    cursorColor: iconColor,
    onChanged:onChanged ,
    textInputAction: TextInputAction.search,
    keyboardType: TextInputType.streetAddress,
    decoration: InputDecoration(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      hintText: hint,
      border: textFieldBorder(),
      fillColor: Colors.white,
      filled: true,
      enabledBorder: textFieldEnableBorder(),
      focusedBorder: textFieldFocusBorder(),
      prefixIcon: Icon(
        Icons.search,
        color: iconColor,
      ),
      suffixIcon: controller.text.isEmpty
          ? null
          : InkWell(
        onTap: () => controller.clear(),
        child: Icon(
          Icons.clear,
          color: Colors.grey,
        ),
      ),
    ),
  );
}