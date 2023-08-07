import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Model/services/service_city_model.dart';
import '../../../services/service/service_apis.dart';
import '../../../utils/colors.dart';
import '../../../utils/helpers/internet_helper.dart';
import '../../../utils/helpers/text_field_validators.dart';
import '../../../utils/styles/text_field_decorations.dart';
import '../../widgets/loader_dialog_view.dart';
import '../landing/landing_screen.dart';

class BookAServiceScreen extends StatefulWidget {
  final String subCategoryId;
  final String subCategoryName;

  const BookAServiceScreen(
      {Key? key, required this.subCategoryId, required this.subCategoryName})
      : super(key: key);

  @override
  State<BookAServiceScreen> createState() => _BookAServiceScreenState();
}

class _BookAServiceScreenState extends State<BookAServiceScreen> {
  List<ServiceCityModel> cityList = <ServiceCityModel>[];

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final _bookAServiceKey = GlobalKey<FormState>();
  String cityId = "";

  @override
  void initState() {
    super.initState();
    getAllCityData();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
  }

  getAllCityData() async {
    cityList = await ServiceApis().getAllCityOfService();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subCategoryName),
      ),
      body: Form(
        key: _bookAServiceKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: [
            requestFormField(
                TextEditingController(text: widget.subCategoryName),
                "Service Type",
                Icons.person_outline,
                enabled: false,
                validator: (text) =>
                    TextFieldValidators(text ?? "").defaultValidator()),
            16.height,
            requestFormField(nameController, "Enter Name", Icons.person_outline,
                maxText: 25,
                keyBoardType: TextInputType.name,
                validator: (text) =>
                    TextFieldValidators(text ?? "").defaultValidator()),
            16.height,
            requestFormField(mobileController, "Enter Mobile Number",
                Icons.phone_android_outlined,
                keyBoardType: TextInputType.phone,
                maxText: 10,
                validator: (text) =>
                    TextFieldValidators(text ?? "").phoneValidator()),
            16.height,
            requestFormField(
                emailController, "Enter Email Address", Icons.email_outlined,
                keyBoardType: TextInputType.emailAddress,
                validator: (text) =>
                    TextFieldValidators(text ?? "").emailValidator()),
            16.height,
            _cityDropDown(),
            24.height,
            _bookServiceButton()
          ],
        ),
      ),
    );
  }

  _cityDropDown() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down_circle,
            color: iconColor,
            size: 20,
          ),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.location_city,
                color: iconColor,
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              enabledBorder: textFieldEnableBorder(),
              errorBorder: textFieldErrorBorder(),
              border: textFieldBorder(),
              focusedBorder: textFieldFocusBorder(),
              focusedErrorBorder: textFieldErrorBorder(),
              disabledBorder: textFieldDisableBorder()),
          value: null,
          hint: Text('Please Choose City',
              style: TextStyle(fontSize: 12, color: textColor)),
          onChanged: (itemId) {
            setState(() {
              cityId = itemId ?? "";
            });
          },
          validator: (value) => value == null ? 'This field is required' : null,
          items: cityList.map((list) {
            return DropdownMenuItem(
              value: list.id.toString(),
              child: FittedBox(
                  child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text(
                  list.cityName ?? "Not Available",
                  style: TextStyle(
                      color: textColor,
                      fontStyle: FontStyle.normal,
                      fontSize: 14),
                ),
              )),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget requestFormField(
      TextEditingController controller, String labelText, IconData preIcon,
      {String? Function(String?)? validator,
      TextInputType keyBoardType = TextInputType.text,
      bool enabled = true,
      int maxText = 200}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
        child: TextFormField(
          maxLength: maxText,
          controller: controller,
          keyboardType: keyBoardType,
          enabled: enabled,
          cursorColor: mainColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            labelStyle: TextStyle(color: textColor, fontSize: 12),
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

  Widget _bookServiceButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
        onPressed: () {
          if (_bookAServiceKey.currentState!.validate()) {
            LoaderDialogView(context).showLoadingDialog();
            ServiceApis().getBookingCode(widget.subCategoryId).then((value) {
              if (value.status == true) {
                LoaderDialogView(context).dismissLoadingDialog();
                ServiceApis()
                    .bookAService(
                        bookCode: value.bookingCode,
                        cityId: cityId,
                        emailAddress: emailController.text,
                        mobile: mobileController.text,
                        name: nameController.text,
                        subCategoryId: widget.subCategoryId)
                    .then((value) {
                  if (value == true) {
                    Fluttertoast.showToast(msg: "Service booked successfully");
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LandingScreen()),
                        (route) => false);
                  } else {
                    Fluttertoast.showToast(msg: "Sorry Service not booked");
                  }
                });
              } else {
                Fluttertoast.showToast(msg: "Something Went Wrong");
              }
            });
          }
        },
        child: Text("Book Service"));
  }
}
