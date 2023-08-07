import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/services/service_category_model.dart';
import 'package:healthcare2050/Model/services/service_city_model.dart';
import 'package:healthcare2050/services/service/service_apis.dart';
import 'package:healthcare2050/utils/helpers/text_field_validators.dart';
import 'package:healthcare2050/view/pages/landing/landing_screen.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/colors.dart';
import '../../../utils/helpers/internet_helper.dart';
import '../../../utils/styles/text_field_decorations.dart';

class BookAServiceWithSubCategoryScreen extends StatefulWidget {
  final List<ServiceSubcategory> subcategory;

  const BookAServiceWithSubCategoryScreen({Key? key, required this.subcategory,})
      : super(key: key);

  @override
  State<BookAServiceWithSubCategoryScreen> createState() => _BookAServiceWithSubCategoryScreenState();
}

class _BookAServiceWithSubCategoryScreenState extends State<BookAServiceWithSubCategoryScreen> {
  List<ServiceCityModel> cityList = <ServiceCityModel>[];

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final _bookServiceKey = GlobalKey<FormState>();
  String cityId = "";
  String subCategoryId = "";

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
        title: Text("Book A Service"),
      ),
      body: Form(
        key: _bookServiceKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: [
            _subCategoryDropDown(),
            16.height,
            requestFormField(nameController, "Enter Name", Icons.person_outline,
              validator: (text)=>TextFieldValidators(text??"").defaultValidator()
            ),
            16.height,
            requestFormField(mobileController, "Enter Mobile Number",
                Icons.phone_android_outlined,
                keyBoardType: TextInputType.number,
                maxText: 10,
                validator: (text)=>TextFieldValidators(text??"").phoneValidator()
            ),
            16.height,
            requestFormField(
                emailController, "Enter Email Address", Icons.email_outlined,
                keyBoardType: TextInputType.emailAddress,
                validator: (text)=>TextFieldValidators(text??"").emailValidator()
            ),
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
            prefixIcon: Icon(Icons.location_city,color: iconColor,),
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
              cityId = itemId??"";
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

  _subCategoryDropDown() {
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
            prefixIcon: Icon(Icons.home_repair_service_outlined,color: iconColor,),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              enabledBorder: textFieldEnableBorder(),
              errorBorder: textFieldErrorBorder(),
              border: textFieldBorder(),
              focusedBorder: textFieldFocusBorder(),
              focusedErrorBorder: textFieldErrorBorder(),
              disabledBorder: textFieldDisableBorder()),
          value: null,
          hint: Text('Please Choose Service',
              style: TextStyle(fontSize: 12, color: textColor)),
          onChanged: (itemId) {
            setState(() {
              subCategoryId = itemId??"";
            });
          },
          validator: (value) => value == null ? 'This field is required' : null,
          items: widget.subcategory.map((list) {
            return DropdownMenuItem(
              value: list.id.toString(),
              child: FittedBox(
                  child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text(
                  list.headerName ?? "Not Available",
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
      int maxText = 200}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
        child: TextFormField(
          cursorColor: mainColor,
          maxLength: maxText,
          controller: controller,
          keyboardType: keyBoardType,
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
          if(_bookServiceKey.currentState!.validate()){
            LoaderDialogView(context).showLoadingDialog();
            ServiceApis().getBookingCode(subCategoryId).then((value){
              if(value.status == true){
                LoaderDialogView(context).dismissLoadingDialog();
                ServiceApis().bookAService(
                  bookCode: value.bookingCode,
                  cityId: cityId,
                  emailAddress: emailController.text,
                  mobile: mobileController.text,
                  name: nameController.text,
                  subCategoryId: subCategoryId
                ).then((value){
                  if(value == true){
                    Fluttertoast.showToast(msg: "Service booked successfully");
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LandingScreen()), (route) => false);
                  }else{
                    Fluttertoast.showToast(msg: "Sorry Service not booked");
                  }
                });
              }else{
                Fluttertoast.showToast(msg: "Something Went Wrong");
              }
            });
          }
        },
        child: Text("Book Service"));
  }
}
