import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/patient/add_patient_details_model.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../../Model/appointments/doctor_appointment_model.dart';
import '../../../../utils/data/local_data_keys.dart';
import '../../../../utils/data/shared_preference.dart';
import '../../../../utils/helpers/internet_helper.dart';
import '../../../../utils/helpers/text_field_validators.dart';
import '../../../../utils/styles/text_field_decorations.dart';
import 'offline_consult_preview_screen.dart';
import 'package:intl/intl.dart';

class OfflinePatientDetailsScreen extends StatefulWidget {
  final DateTime currentDate;
  final DoctorAppointmentModel doctorData;
  final String cityId;
  final String slotId;
  final String slotTiming;
  final String slotDate;
  final String amount;

  const OfflinePatientDetailsScreen(
      {Key? key,
      required this.currentDate,
      required this.doctorData,
      required this.cityId,
      required this.slotId,
      required this.slotTiming,
      required this.slotDate, required this.amount})
      : super(key: key);

  @override
  State<OfflinePatientDetailsScreen> createState() =>
      _OfflinePatientDetailsScreenState(doctorData);
}

class _OfflinePatientDetailsScreenState
    extends State<OfflinePatientDetailsScreen> {
  final DoctorAppointmentModel doctorData;

  _OfflinePatientDetailsScreenState(this.doctorData);

  final _appointmentKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var phoneController = TextEditingController();

  var genders = ['Male', 'Female', 'Other'];
  String _selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Patient Details"),
      ),
      body: Form(
        key: _appointmentKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _consultationTextFieldView("Patient Name", nameController,
                    validator: (text) =>
                        TextFieldValidators(text ?? "").defaultValidator()),
                _consultationTextFieldView("Patient Age", ageController,
                    keyBoardType: TextInputType.number,
                    maxLength: 3,
                    validator: (text) =>
                        TextFieldValidators(text ?? "").ageValidator()),
                _consultationTextFieldView("Patient Mobile", phoneController,
                    keyBoardType: TextInputType.number,
                    maxLength: 10,
                    validator: (text) =>
                        TextFieldValidators(text ?? "").phoneValidator()),
                5.height,
                SizedBox(
                  height: 55,
                  child: _patientGenderDropdown(),
                ),
                30.height,
                ElevatedButton.icon(
                  onPressed: () async {
                    var userId = await getStringFromLocal(userIdKey);
                    if (_appointmentKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AppointmentPreviewPageScreen(
                                    doctorDetails: doctorData,
                                    slotTiming: widget.slotTiming, patientDetails: AddPatientDetailsModel(
                                      doctorId: doctorData.id.toString(),
                                      userId: userId,
                                      specializationId:
                                      doctorData.specId.toString(),
                                      patientName: nameController.text,
                                      patientAge: ageController.text,
                                      patientGender: _selectedGender,
                                      patientMobile: phoneController.text,
                                      cityId: widget.cityId,
                                      consultType: "3",
                                      pinCode: "",
                                      slotId: widget.slotId,
                                      consultDate: DateFormat('yyyy-MM-dd')
                                          .format(widget.currentDate)), amount: widget.amount,
                                  )));
                    }
                  },
                  icon: Icon(Icons.save),
                  label: Text(
                    "Save Details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      fixedSize: Size(100.w, 5.5.h)), //label text
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onGenderSelected(String genderKey) {
    setState(() {
      _selectedGender = genderKey;
    });
  }

  Widget _consultationTextFieldView(
      String labelText, TextEditingController controller,
      {int maxLength = 100,
      String? Function(String?)? validator,
      TextInputType keyBoardType = TextInputType.text,
      bool isEnabled = true,
      void Function(String)? onChanged}) {
    return SizedBox(
      child: TextFormField(
        maxLength: maxLength,
        validator: validator,
        onChanged: onChanged,
        cursorColor: textColor,
        controller: controller,
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
      ).paddingSymmetric(vertical: 5),
    );
  }

  Widget _patientGenderDropdown() {
    return DropdownButtonFormField(
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
            .map((String item) => DropdownMenuItem<String>(
                  child: Text(item),
                  value: item,
                ))
            .toList(),
        onChanged: (String? value) {
          setState(() {
            _selectedGender = value ?? "Male";
          });
        });
  }
}
