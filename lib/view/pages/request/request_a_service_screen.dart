
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthcare2050/Providers/CityListProvider.dart';
import 'package:healthcare2050/services/requests/request_a_service.dart';
import 'package:healthcare2050/constants/constants.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/helpers/text_field_validators.dart';
import 'package:healthcare2050/view/pages/landing/landing_screen.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/helpers/internet_helper.dart';
import '../../../utils/styles/text_field_decorations.dart';

class RequestAServiceScreen extends StatefulWidget {
  const RequestAServiceScreen({Key? key}) : super(key: key);

  @override
  State<RequestAServiceScreen> createState() => _RequestAServiceScreenState();
}

class _RequestAServiceScreenState extends State<RequestAServiceScreen> {
  final GlobalKey<FormState> _requestFormKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController,
      _lastNameController,
      _mobileController,
      _emailController,
      _serviceController;

  String buttonText = "Request a service";

  String? city_dropdown_id;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _mobileController = TextEditingController();
    _emailController = TextEditingController();
    _serviceController = TextEditingController();
    final dataCity = Provider.of<CityListProvider>(context, listen: false);
    dataCity.fetchCity();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
  }

  @override
  void dispose() {
    super.dispose();

    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _serviceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataCity = Provider.of<CityListProvider>(context); //GET

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Request Service"),
        backgroundColor: themColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: width,
          height: height,
          child: Form(
            key: _requestFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  requestFormField(_firstNameController,
                      "Enter your first name", Icons.person, validator: (text) {
                    return TextFieldValidators(text ?? '').defaultValidator();
                  }),
                  SizedBox(
                    height: 5,
                  ),
                  requestFormField(
                      _lastNameController, "Enter your last name", Icons.person,
                      validator: (text) {
                    return TextFieldValidators(text ?? '').defaultValidator();
                  }),
                  SizedBox(
                    height: 5,
                  ),
                  requestFormField(_mobileController,
                      "Enter your mobile number", Icons.phone_android,
                      keyBoardType: TextInputType.number,
                      maxText: 10,
                      validator: (text) =>
                          TextFieldValidators(text ?? '').phoneValidator()),
                  SizedBox(
                    height: 5,
                  ),
                  requestFormField(_emailController, "Enter your email address",
                      Icons.person,
                      keyBoardType: TextInputType.emailAddress,
                      validator: (text) =>
                          TextFieldValidators(text ?? '').emailValidator()),
                  SizedBox(
                    height: 5,
                  ),
                  requestFormField(
                      _serviceController, "Enter a service name", Icons.person,
                      validator: (text) =>
                          TextFieldValidators(text ?? '').defaultValidator()),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.white,
                          splashColor: iconColor.withOpacity(0.5),
                        ),
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down_circle,
                            color: iconColor,
                            size: 20,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.home_repair_service,
                              color: iconColor,
                            ),
                            focusedBorder: textFieldFocusBorder(),
                            enabledBorder: textFieldEnableBorder(),
                            errorBorder: textFieldErrorBorder(),
                            disabledBorder: textFieldDisableBorder(),
                            focusedErrorBorder: textFieldErrorBorder(),
                            border: textFieldBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          value: null,
                          hint: Text('Please Choose City',
                              style: TextStyle(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.w600,
                                  color: textColor)),
                          onChanged: (itemId) {
                            setState(() {
                              city_dropdown_id = itemId!;
                            });

                          },
                          validator: (value) => TextFieldValidators(value ?? "")
                              .defaultValidator(),
                          items: dataCity.cityList.map((list) {
                            return DropdownMenuItem(
                              value: list['Id'].toString(),
                              child: FittedBox(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Text(
                                  list['CityName'].toString(),
                                  style: TextStyle(
                                      color: themColor,
                                      //fontWeight: FontWeight.w800,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16),
                                ),
                              )),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    child: Text(
                      'Request a service',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: themColor, fixedSize: Size(90.w, 6.h),
                    ),
                    onPressed: () async {
                      requestService();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget requestFormField(
      TextEditingController controller, String labelText, IconData preIcon,
      {String? Function(String?)? validator,
      TextInputType keyBoardType = TextInputType.text,int maxText = 200}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
        child: TextFormField(
          maxLength: maxText,
          controller: controller,
          keyboardType: keyBoardType,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            labelStyle: TextStyle(
              color: textColor,
            ),
            counterText: '',
            prefixIcon: Icon(
              preIcon,
              color: iconColor,
            ),
            focusedBorder: textFieldFocusBorder(),
            enabledBorder: textFieldEnableBorder(),
            errorBorder: textFieldErrorBorder(),
            disabledBorder: textFieldDisableBorder(),
            border: textFieldBorder(),
            focusedErrorBorder: textFieldErrorBorder(),
            labelText: labelText,
          ),
          validator: validator,
        ),
      ),
    );
  }

  requestService() {
    if (_requestFormKey.currentState!.validate()) {
      try {
        LoaderDialogView(context).showLoadingDialog();
        RequestAService.sendRequestForService(
            _firstNameController.text.toString(),
            _lastNameController.text.toString(),
            _emailController.text.toString(),
            _serviceController.text.toString(),
            _mobileController.text.toString(),
            city_dropdown_id.toString()).then((value){
              if(value == true){
                LoaderDialogView(context).dismissLoadingDialog();
                Fluttertoast.showToast(msg: "Request Successfully");
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LandingScreen()), (route) => false);
              }else{
                LoaderDialogView(context).dismissLoadingDialog();
                Fluttertoast.showToast(msg: "Request Failed, Please try again");
              }
        });
      } catch (err) {
        print(err);
      }
    }
  }
}
