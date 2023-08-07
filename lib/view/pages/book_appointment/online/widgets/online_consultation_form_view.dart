import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/patient/add_patient_details_model.dart';
import 'package:healthcare2050/utils/data/local_data_keys.dart';
import 'package:healthcare2050/utils/data/shared_preference.dart';
import 'package:healthcare2050/utils/helpers/internet_helper.dart';
import 'package:healthcare2050/utils/helpers/text_field_validators.dart';
import 'package:healthcare2050/view/pages/book_appointment/online/online_appointment_preview_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../../../Model/appointments/online/online_doctor_model.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/styles/text_field_decorations.dart';

class OnlineConsultationFormView extends StatefulWidget {
  final OnlineDoctorsModel doctorsModel;
  final String speId;
  final String slotId;
  final String date;
  final String consultType;
  final String slotTiming;
  final String slotDate;

  OnlineConsultationFormView({Key? key,
    required this.doctorsModel,
    required this.speId,
    required this.slotId,
    required this.date,
    required this.consultType, required this.slotTiming, required this.slotDate})
      : super(key: key);

  @override
  State<OnlineConsultationFormView> createState() =>
      _OnlineConsultationFormViewState();
}

class _OnlineConsultationFormViewState
    extends State<OnlineConsultationFormView> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _mobileController = TextEditingController();
  final _pinController = TextEditingController();


  var genders = ['Male', 'Female', 'Other'];
  String _selectedGender = 'Male';

  final _onlineFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    InternetHelper(context: context).checkConnectivityRealTime(
        callBack: (a) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Patient Details"),
      ),
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height * .65,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _onlineFormKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,
              _consultationTextFieldView("Patient Name", _nameController,
                  validator: (text) =>
                      TextFieldValidators(text ?? "").defaultValidator()),
              _consultationTextFieldView("Patient Age", _ageController,
                  keyBoardType: TextInputType.number,
                  maxLength: 3,
                  validator: (text) =>
                      TextFieldValidators(text ?? "").ageValidator()),
              _consultationTextFieldView("Patient Mobile", _mobileController,
                  keyBoardType: TextInputType.number,
                  maxLength: 10,
                  validator: (text) =>
                      TextFieldValidators(text ?? "").phoneValidator()),
              _consultationTextFieldView("Patient PinCode", _pinController,
                  keyBoardType: TextInputType.number,
                  maxLength: 6,
                  autoValidate: AutovalidateMode.onUserInteraction,
                  validator: (text) =>
                      TextFieldValidators(text ?? "").pinCodeValidator()),
              5.height,
              _patientGenderDropdown(),
              20.height,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: buttonColor,
                      fixedSize: Size(100.w, 6.h)),
                  onPressed: () async {
                    if (_onlineFormKey.currentState!.validate()) {
                      var userId = await getStringFromLocal(userIdKey);
                      var patientDetails = AddPatientDetailsModel(
                          doctorId: widget.doctorsModel.id.toString(),
                          userId: userId,
                          specializationId: widget.speId,
                          patientName: _nameController.text,
                          patientAge: _ageController.text,
                          patientGender: _selectedGender,
                          patientMobile: _mobileController.text,
                          cityId: "",
                          consultType: widget.consultType,
                          slotId: widget.slotId,
                          consultDate: widget.date,
                      pinCode: _pinController.text);


                      finish(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OnlineAppointmentPreviewScreen(
                                    doctorsModel: widget.doctorsModel,
                                    patientDetails: patientDetails,
                                    slotTiming: widget.slotTiming,
                                  )));
                    }
                  },
                  child: Text(
                    "Save Details",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _consultationTextFieldView(String labelText,
      TextEditingController controller,
      {int maxLength = 100,
        String? Function(String?)? validator,
        TextInputType keyBoardType = TextInputType.text,
        bool isEnabled = true,
        AutovalidateMode autoValidate = AutovalidateMode.disabled,
        void Function(String)? onChanged}) {
    return TextFormField(
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      cursorColor: textColor,
      controller: controller,
      autovalidateMode: autoValidate,
      keyboardType: keyBoardType,
      enabled: isEnabled,
      decoration: InputDecoration(
          labelText: labelText,
          counterText: "",
          labelStyle: TextStyle(color: textColor),
          border: textFieldBorder(),
          focusedBorder: textFieldFocusBorder(),
          errorBorder: textFieldErrorBorder(),
          disabledBorder: textFieldBorder(),
          enabledBorder: textFieldEnableBorder(),
          focusedErrorBorder: textFieldErrorBorder()),
    ).paddingSymmetric(vertical: 5);
  }

  Widget _patientGenderDropdown() {
    return SizedBox(
      height: 55,
      child: DropdownButtonFormField(
          value: _selectedGender,
          decoration: InputDecoration(
              labelText: "Select a gender",
              labelStyle: TextStyle(color: textColor),
              border: textFieldBorder(),
              focusedBorder: textFieldFocusBorder(),
              errorBorder: textFieldErrorBorder(),
              disabledBorder: textFieldBorder(),
              enabledBorder: textFieldEnableBorder(),
              focusedErrorBorder: textFieldErrorBorder()),
          validator: (String? text) {
            if (text!.isEmpty) {
              return "Please select a gender";
            } else {
              return null;
            }
          },
          items: genders
              .map((String item) =>
              DropdownMenuItem<String>(
                child: Text(item),
                value: item,
              ))
              .toList(),
          onChanged: (String? value) {
            setState(() {
              _selectedGender = value ?? "Male";
            });
          }),
    );
  }
}
