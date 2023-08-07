import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/data/server_data.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/styles/image_style.dart';
import '../../../../utils/styles/text_field_decorations.dart';

Widget userProfilePictureView(File? imagePath,String pictureUrl) {
  return ClipRRect(
    child: imagePath == null?showNetworkImageWithCached(
        imageUrl: pictureServerPath+pictureUrl,
        height: 25.h,
        width: 45.w,
        radius: 5,
        fit: BoxFit.cover):Image.file(
        imagePath,
        height: 25.h,
        width: 45.w,
        fit: BoxFit.cover),
    borderRadius: BorderRadius.circular(5),
  );
}

takePictureItem(IconData icon, String title,
    {required void Function()? onPressed, Color iconColor = Colors.red}) {
  return Row(
    children: [
      InkWell(
        onTap: onPressed,
        child: AvatarGlow(
          endRadius: 40.0,
          child: Material(
            elevation: 8.0,
            shape: CircleBorder(),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: IconButton(
                  onPressed: onPressed, icon: Icon(icon, color: iconColor)),
              radius: 20.0,
            ),
          ),
        ),
      ),
      10.width,
      Text(title,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white))
    ],
  );
}

Widget updateUserDetailsTextFieldView(
    String labelText, TextEditingController controller,
    {int maxLength = 100,
    String? Function(String?)? validator,
      TextInputType keyBoardType = TextInputType.text,
      bool isEnabled = true,
      AutovalidateMode autoValidate  = AutovalidateMode.disabled,
    void Function(String)? onChanged}) {
  return TextFormField(
    maxLength: maxLength,
    validator: validator,
    onChanged: onChanged,
    cursorColor: textColor,
    controller: controller,
    keyboardType: keyBoardType,
    enabled: isEnabled,
    autovalidateMode: autoValidate,
    decoration: InputDecoration(
        labelText: labelText,
        counterText: "",
        labelStyle: TextStyle(color: textColor),
        border: textFieldBorder(),
        focusedBorder: textFieldFocusBorder(),
        errorBorder: textFieldErrorBorder(),
        disabledBorder: textFieldBorder(),
        enabledBorder: textFieldEnableBorder(),
        focusedErrorBorder: textFieldErrorBorder()),
  ).paddingSymmetric(vertical: 10);
}
