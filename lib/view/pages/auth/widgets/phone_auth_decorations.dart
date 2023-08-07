

import 'package:flutter/material.dart';

OutlineInputBorder phoneInputBorder() {

  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.indigo,
        width: 2,
      ));
}

OutlineInputBorder phoneFocusBorder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.green,
        width: 1,
      ));
}