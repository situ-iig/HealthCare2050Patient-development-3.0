import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/styles/image_style.dart';
import 'package:healthcare2050/view/pages/profile/edit_profile_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';



Widget profileImageView(String imageUrl,BuildContext context){
  return InkWell(
    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>FullScreenImageView(imageUrl: imageUrl,),fullscreenDialog: true)),
    child: Container(
      height: 140,
      width: 130,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: showNetworkImageWithCached(imageUrl: imageUrl, height: 150, width: 150, radius: 10),
      ),
    ),
  );
}


Widget userDetailsItemView(String title,String name,BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,style: TextStyle(color: Colors.grey,fontSize: 12),),
      Divider(thickness: 1,color: Colors.white,height: 2,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name,style: TextStyle(color: Colors.white),),
          IconButton(
            padding: EdgeInsets.all(10),
              onPressed: (){
            EditProfileScreen().launch(context,pageRouteAnimation: PageRouteAnimation.Slide,duration: Duration(milliseconds: 1000));
          }, icon: Icon(Icons.edit,color: Colors.white,)),
        ],
      )
      //Divider(thickness: 1,color: Colors.white,)
    ],
  ).paddingSymmetric(horizontal: 10);
}

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;
  const FullScreenImageView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Picture"),
        actions: [
          IconButton(onPressed: (){
            finish(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
          }, icon: Icon(Icons.edit))
        ],
      ),
      body: showNetworkImageWithCached(imageUrl: imageUrl, height: 100.h, width: 100.w, radius: 0),
    );
  }
}

