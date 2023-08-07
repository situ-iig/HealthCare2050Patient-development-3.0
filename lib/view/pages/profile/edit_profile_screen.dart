import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:healthcare2050/Providers/user_details_provider.dart';
import 'package:healthcare2050/services/profile/profile_apis.dart';
import 'package:healthcare2050/utils/helpers/internet_helper.dart';
import 'package:healthcare2050/utils/helpers/text_field_validators.dart';
import 'package:healthcare2050/view/pages/profile/widgets/edit_profile_widgets.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/colors.dart';
import '../../../utils/data/local_data_keys.dart';
import '../../../utils/data/shared_preference.dart';
import '../../../utils/styles/text_field_decorations.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var f_nameController = TextEditingController();
  var l_nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();
  var pinCodeController = TextEditingController();
  var addressController = TextEditingController();

  final _editProfileKey = GlobalKey<FormState>();

  String profilePicUrl = "";
  File? imageFile;

  Uint8List? bytes;

  @override
  void initState() {
    getUserDetails();
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (a) {});
    Provider.of<UserDetailsProvider>(context,listen: false).getUserDetails();
  }

  getUserDetails() async {
    var value = Provider.of<UserDetailsProvider>(context,listen: false).getUserDetails();
    profilePicUrl = await getStringFromLocal(userProfilePicKey);
    f_nameController = TextEditingController();
    l_nameController = TextEditingController();
    emailController = TextEditingController(text: value.getEmail);
    mobileController = TextEditingController(text: value.getMobile);
    stateController = TextEditingController(text: value.getStateName);
    cityController = TextEditingController(text: value.getCityName);
    pinCodeController = TextEditingController(text: value.getPinCode);
    addressController = TextEditingController(text: value.getAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Edit Profile"),
      ),
      backgroundColor: secondaryBgColor,
      body: ListView(
        children: [
          20.height,
          Container(
            height: 35.h,
            child: Row(
              children: [
                Expanded(
                    child: Consumer<UserDetailsProvider>(builder: (a,value,b){
                      return userProfilePictureView(imageFile, value.getProfileImage)
                          .paddingAll(20);
                    },)),
                Expanded(child: takeUserPictureView())
              ],
            ),
          ),
          Container( child: _userDetailsView())
        ],
      ),
    );
  }

  Widget takeUserPictureView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        takePictureItem(Icons.camera_alt_outlined, "Camera", onPressed: () {
          _takeImageFrom(ImageSource.camera);
        }, iconColor: iconColor),
        takePictureItem(Icons.photo_camera_back, "Gallery", onPressed: () {
          _takeImageFrom(ImageSource.gallery);
        }, iconColor: iconColor),
        // takePictureItem(Icons.edit, "Edit", onPressed: () {})
      ],
    );
  }

  Widget _userDetailsView() {
    return Consumer<UserDetailsProvider>(builder: (BuildContext context, value, Widget? child) {
      emailController = TextEditingController(text: value.getEmail);
      mobileController = TextEditingController(text: value.getMobile);
      stateController = TextEditingController(text: value.getStateName);
      cityController = TextEditingController(text: value.getCityName);
      pinCodeController = TextEditingController(text: value.getPinCode);
      addressController = TextEditingController(text: value.getAddress);
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Form(
          key: _editProfileKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            physics: NeverScrollableScrollPhysics(),
            children: [
              // updateUserDetailsTextFieldView(
              //     "Enter your first name", f_nameController,
              //     validator: (text) =>
              //         TextFieldValidators(text ?? "").defaultValidator()),
              // updateUserDetailsTextFieldView(
              //     "Enter your last name", l_nameController,
              //     validator: (text) =>
              //         TextFieldValidators(text ?? "").defaultValidator()),
              // 5.height,
              TextField(
                enabled: false,
                controller: mobileController,
                decoration: InputDecoration(
                    border: textFieldBorder(),
                    focusedBorder: textFieldFocusBorder(),
                    errorBorder: textFieldErrorBorder(),
                    disabledBorder: textFieldBorder(),
                    enabledBorder: textFieldEnableBorder(),
                    focusedErrorBorder: textFieldErrorBorder(),
                    labelText: "Mobile Number"),
              ),
              7.height,
              updateUserDetailsTextFieldView(
                  "Enter your email address", emailController,
                  keyBoardType: TextInputType.emailAddress,
                  validator: (text) =>
                      TextFieldValidators(text ?? "").emailValidator()),
              updateUserDetailsTextFieldView(
                  "Enter your address", addressController,
                  validator: (text) =>
                      TextFieldValidators(text ?? "").defaultValidator()),
              updateUserDetailsTextFieldView(
                  "Enter your pin code", pinCodeController,
                  maxLength: 6,
                  keyBoardType: TextInputType.number,
                  autoValidate: AutovalidateMode.onUserInteraction,
                  validator: (text) =>
                      TextFieldValidators(text ?? "").pinCodeValidator()),
              updateUserDetailsTextFieldView(
                  "Enter your city name", cityController,
                  validator: (text) =>
                      TextFieldValidators(text ?? "").defaultValidator()),
              updateUserDetailsTextFieldView(
                  "Enter your state name", stateController,
                  validator: (text) =>
                      TextFieldValidators(text ?? "").defaultValidator()),
              20.height,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryBgColor,
                      fixedSize: Size(90.w, 6.h),
                      elevation: 5),
                  onPressed: () {
                    updateUserDetails();
                  },
                  child: Text(
                    "Update",
                    style: boldTextStyle(size: 16, color: Colors.white),
                  ))
            ],
          ),
        ),
      );
    },);
  }

  void _takeImageFrom(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      setState(
        () {
          imageFile = File(pickedFile.path);
        },
      );
      bytes = imageFile!.readAsBytesSync();
    }
  }

  updateUserDetails() {
    var provider = Provider.of<UserDetailsProvider>(context,listen: false);
    if(_editProfileKey.currentState!.validate()){
      LoaderDialogView(context).showLoadingDialog();
      if(bytes != null){
        ProfileApis().uploadUserImage(bytes!,provider).then((value) {
          if (value == true) {
            ProfileApis().updateUserDetails(
                emailController.text,
                cityController.text,
                stateController.text,
                pinCodeController.text,
                addressController.text,provider).then((value) {
              LoaderDialogView(context).dismissLoadingDialog();
              Fluttertoast.showToast(msg: "Update Successful");
              finish(context);
            });
          } else {
            Fluttertoast.showToast(msg: "Image not uploaded");
          }
        });
      }else{
        ProfileApis().updateUserDetails(
            emailController.text,
            cityController.text,
            stateController.text,
            pinCodeController.text,
            addressController.text,provider).then((value){
          LoaderDialogView(context).dismissLoadingDialog();
          Fluttertoast.showToast(msg: "Update Successful");
          finish(context);
        });
      }

    }
  }
}
