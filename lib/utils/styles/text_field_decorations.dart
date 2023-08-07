
import 'package:flutter/material.dart';

import '../colors.dart';

OutlineInputBorder textFieldBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(width: 2.0, color: Colors.grey));
}

OutlineInputBorder textFieldEnableBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: secondaryBgColor, width: 2.0),
  );
}

OutlineInputBorder textFieldFocusBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: secondaryBgColor, width: 2.0),
  );
}

OutlineInputBorder textFieldErrorBorder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  );
}

OutlineInputBorder textFieldDisableBorder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
    borderSide: BorderSide(width: 2.0, color: Colors.grey),
  );
}