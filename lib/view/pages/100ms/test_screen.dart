import 'package:flutter/material.dart';
import 'package:healthcare2050/view/pages/100ms/start_video_service.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {


  var nurseToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2Nlc3Nfa2V5IjoiNjNmNzE3ODY2N2RjZjgwM2JkYjYzMmQ3Iiwicm9vbV9pZCI6IjY0MDZjMmM1ZGE3ZTdjYTgxMjg0MGVhYiIsInVzZXJfaWQiOiJ3cnRibHBpbSIsInJvbGUiOiJudXJzZSIsImp0aSI6Ijg1YmFkNjQ4LWI1OGEtNDE5Zi04NmI0LTYyYzViZTk5Y2EzYiIsInR5cGUiOiJhcHAiLCJ2ZXJzaW9uIjoyLCJleHAiOjE2Nzg5NDgxNzd9.Wv1eUtyEpd4Du3694YUvo65Ek00F7qTECTJ8kIO7728';
  // var hostToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2Nlc3Nfa2V5IjoiNjNmNzE3ODY2N2RjZjgwM2JkYjYzMmQ3Iiwicm9vbV9pZCI6IjY0MDZjMmM1ZGE3ZTdjYTgxMjg0MGVhYiIsInVzZXJfaWQiOiJqemRya2didCIsInJvbGUiOiJob3N0IiwianRpIjoiNTQyODg3MjMtZjJlNS00Y2JhLTlmZjItMWZiNWJjNGQ5ZjQwIiwidHlwZSI6ImFwcCIsInZlcnNpb24iOjIsImV4cCI6MTY3ODg2MDI5Mn0.CExhL-her32MMRLysqOpjALZAMM0BHN9YhEodSLxtxw";

  String name = "Susant Barik";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          startVideoService(context,userName: name, meetingToken: nurseToken);
        }, child: Text("Join Meeting")),
      ),
    );
  }
}
