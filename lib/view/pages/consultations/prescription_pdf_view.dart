
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:healthcare2050/utils/helpers/internet_helper.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/colors.dart';

class PrescriptionPdfView extends StatefulWidget {
  final String document;
  const PrescriptionPdfView({Key? key, required this.document}) : super(key: key);

  @override
  State<PrescriptionPdfView> createState() => _PrescriptionPdfViewState();
}

class _PrescriptionPdfViewState extends State<PrescriptionPdfView> {


  @override
  void initState() {
    InternetHelper(context: context).checkConnectivityRealTime(callBack: (a){});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Prescription"),
      ),
      body:Stack(
        children: [
          PDF().cachedFromUrl(widget.document,errorWidget: (a){
            return Center(child: Text("PDF Not Available Now"),);
          },placeholder: (a){
            return Center(child: CircularProgressIndicator(color: iconColor,),);
          }) ,
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: buttonColor),
                onPressed: (){
                //downloadPdf(widget.document);
                  _urlLauncher(widget.document);
                }, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Download Prescription",style: TextStyle(color: Colors.white),),
                5.width,
                Icon(Icons.download,color: Colors.white,)
              ],
            )),
          )
        ],
      )
    );
  }

  _urlLauncher(String url)async{
    return await launch(url);
  }
}
