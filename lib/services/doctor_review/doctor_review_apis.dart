import 'dart:convert';

import 'package:healthcare2050/utils/data/local_data_keys.dart';
import 'package:healthcare2050/utils/data/shared_preference.dart';
import 'package:http/http.dart' as http;

import '../../Api/Api.dart';
import '../../Model/doctor_review/review_feedback_list_model.dart';

class DoctorReviewApis{
  Future<List<ReviewFeedbackListModel>> getFeedbackList()async{
    var url = Uri.parse(getFeedbackListApi);
    var response = await http.get(url);
    if(response.statusCode == 200){
      var resData = jsonDecode(response.body);
      if(resData['doctorDetail'] != []){
        List data = resData['doctorDetail'];
        return data.map((e) => ReviewFeedbackListModel.fromJson(e)).toList();
      }else{
        return List<ReviewFeedbackListModel>.empty();
      }
    }else{
      return List<ReviewFeedbackListModel>.empty();
    }
  }

  Future<bool> postDoctorReview(
      String doctorId,
      String ratings,
      int feedbacks,
      String message
      )async{
    var userId = await getStringFromLocal(userIdKey);
    var url = Uri.parse(postDoctorReviewApi);
    var response = await http.post(url,body: {
      "UserId":userId,
      "DoctorId":doctorId,
      "Rating":ratings,
      "FeedBackList":feedbacks.toString(),
      "Message":message
    });
    if(response.statusCode == 200){
      var resData = jsonDecode(response.body);
      if(resData['status'] == true){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }
}