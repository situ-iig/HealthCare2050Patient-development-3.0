import 'package:flutter/material.dart';
import 'package:healthcare2050/view/widgets/app_shimmer_view.dart';
import 'package:sizer/sizer.dart';

class HomeShimmerScreen extends StatelessWidget {
  const HomeShimmerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 5),
      children: [
        appShimmerView(height*.25,100.w),
        _appointmentShimmerView(),
        SizedBox(
          height: 50.h,
          child: _servicesShimmerView(),
        )
      ],
    );
  }

  _appointmentShimmerView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        appShimmerView(25.h,46.w),
        appShimmerView(25.h,46.w)
      ],
    );
  }

  _servicesShimmerView(){
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 9,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return appShimmerView(120, 120);
      },
    );
  }

}
