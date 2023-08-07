import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/colors.dart';

import '../../../utils/constants/basic_strings.dart';
import '../home/widgets/home_widgets.dart';

class AppDescriptionScreen extends StatelessWidget {
  const AppDescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Description"),
      ),
      body: ListView(
        children: [
          showOurDetailsView(appName,
              "assets/images/satisfiedCustomer.png", about2050),
          showOurDetailsView("With you in Every Step of Healing",
              "assets/images/every_step_img.jpg", aboutDescription),
        ],
      ),
    );
  }
}
