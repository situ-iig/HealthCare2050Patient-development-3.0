import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

class LoaderDialogView  {
  BuildContext context;

  LoaderDialogView(this.context);


 Widget loaderDialogView() => AlertDialog(
    content: SizedBox(
      height: 40,
      width: 90.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(child: CircularProgressIndicator(color: iconColor,)),
          20.width,
          Text("Loading...",style: TextStyle(color: textColor),)
        ],
      ),
    ),
  );

  showLoadingDialog(){
    return showDialog(
      barrierDismissible: true,
        context: context, builder: (context) => loaderDialogView());
  }
  dismissLoadingDialog() => Navigator.pop(context);

}

class ScreenLoadingView extends StatelessWidget {
  const ScreenLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/Logo/logo_gif.gif",
            width: 80,
            height: 80,
          ),
          10.height,
          Text("Loading....")
        ],
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Oops, Something went wrong",style: boldTextStyle(color: textColor,size: 20),),
          10.height,
          Text("Do not worry, We will fix it soon",style: TextStyle(color: Colors.grey,fontSize: 12),)
        ],
      ).paddingSymmetric(horizontal: 10),
    );
  }
}



