import 'package:flutter/material.dart';
import 'package:healthcare2050/services/doctor_review/doctor_review_apis.dart';
import 'package:healthcare2050/utils/styles/text_field_decorations.dart';
import 'package:healthcare2050/view/pages/landing/landing_screen.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../Model/doctor_review/review_feedback_list_model.dart';
import '../../../utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../utils/helpers/internet_helper.dart';

class DoctorReviewScreen extends StatefulWidget {
  final String doctorId;

  const DoctorReviewScreen({Key? key, required this.doctorId})
      : super(key: key);

  @override
  State<DoctorReviewScreen> createState() => _DoctorReviewScreenState();
}

class _DoctorReviewScreenState extends State<DoctorReviewScreen> {
  late TextEditingController _commentController;
  int selectedIndex = -1;
  int selectedItemId = 0;
  double ratings = 0.0;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Review'),
      ),
      body: WillPopScope(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'How was your experience?',
                    style: boldTextStyle(size: 20, color: textColor),
                  ),
                  10.height,
                  SizedBox(
                    height: 200,
                    child: _commentView(),
                  ),
                  _ratingView(),
                  10.height,
                  _ratingCommentView(),
                  _reviewSubmitButton()
                ],
              ).paddingSymmetric(horizontal: 10, vertical: 20),
            ),
          ),
          onWillPop: () {
            return goToHome();
          }),
    );
  }

  goToHome() {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LandingScreen()),
        (route) => false);
  }

  _ratingView() {
    return RatingBarWidget(
        itemCount: 5,
        activeColor: iconColor,
        allowHalfRating: true,
        size: 60,
        spacing: 10,
        rating: ratings,
        inActiveColor: iconColor.withOpacity(.5),
        onRatingChanged: (value) {
          setState(() {
            ratings = value;
          });
        });
  }

  _ratingCommentView() {
    return SizedBox(
      width: 90.w,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: 8,
        controller: _commentController,
        maxLength: 250,
        cursorColor: textColor,
        decoration: InputDecoration(
            border: textFieldBorder(),
            enabledBorder: textFieldEnableBorder(),
            focusedBorder: textFieldFocusBorder()),
      ),
    );
  }

  _commentView() {
    return FutureBuilder(
      future: DoctorReviewApis().getFeedbackList(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<ReviewFeedbackListModel> data = snapshot.data;
          return data.isNotEmpty
              ? MasonryGridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return _feedbackListItemView(data[index], index);
                  },
                )
              : Center(
                  child: Text(
                    "No data available",
                    style: boldTextStyle(color: Colors.grey),
                  ),
                );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: iconColor,
            ),
          );
        }
      },
    );
  }

  _feedbackListItemView(ReviewFeedbackListModel data, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
          selectedItemId = data.id ?? 0;
        });
      },
      child: Card(
        color: selectedIndex == index ? buttonColor : Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
                width: 1,
                color: selectedIndex == index ? Colors.grey : textColor)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data.listName ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: selectedIndex == index ? Colors.white : textColor),
          ),
        ),
      ),
    );
  }

  _reviewSubmitButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: buttonColor, fixedSize: Size(90.w, 5.5.h)),
        onPressed: () {
          LoaderDialogView(context).showLoadingDialog();
          DoctorReviewApis()
              .postDoctorReview(widget.doctorId, ratings.toString(),
                  selectedItemId, _commentController.text)
              .then((value) {
            LoaderDialogView(context).dismissLoadingDialog();
            if (value == true) {
              goToHome();
            } else {
              Fluttertoast.showToast(msg: "Something went wrong");
            }
          });
        },
        child: Text("Submit"));
  }
}
