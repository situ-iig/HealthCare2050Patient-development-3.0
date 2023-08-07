// Package imports
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/styles/text_field_decorations.dart';
import 'package:healthcare2050/view/pages/100ms/common/util/app_color.dart';

class ChangeNameDialog extends StatefulWidget {
  const ChangeNameDialog({Key? key}) : super(key: key);

  @override
  _ChangeNameDialogState createState() => _ChangeNameDialogState();
}

class _ChangeNameDialogState extends State<ChangeNameDialog> {
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        autofocus: true,
        controller: userNameController,
        style: GoogleFonts.inter(color: Colors.white),
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(16)),
            // ),
          border: textFieldBorder(),
            enabledBorder: textFieldEnableBorder(),
            focusedBorder: textFieldFocusBorder(),
            hintText: 'Enter your Name',
            hintStyle: GoogleFonts.inter(
              color: Colors.white,
            )),
      ),
      actions: [
        ElevatedButton(
          style:ElevatedButton.styleFrom(backgroundColor: errorColor),
          child: Text(
            'Cancel',
            style: GoogleFonts.inter(),
          ),
          onPressed: () {
            Navigator.pop(context, '');
          },
        ),
        ElevatedButton(
          style:ElevatedButton.styleFrom(backgroundColor: mainColor),
          child: Text(
            'OK',
            style: GoogleFonts.inter(),
          ),
          onPressed: () {
            Navigator.pop(context, userNameController.text);
          },
        ),
      ],
    );
  }
}
