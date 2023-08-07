class AddPatientDetailsModel {
  String doctorId;
  String userId;
  String specializationId;
  String patientName;
  String patientAge;
  String patientMobile;
  String consultDate;
  String slotId;
  String consultType;
  String patientGender;
  String cityId;
  String pinCode;

  AddPatientDetailsModel(
      {required this.doctorId,
      required this.userId,
      required this.specializationId,
      required this.patientName,
      required this.patientAge,
      required this.patientGender,
      required this.patientMobile,
      required this.cityId,
      required this.consultType,
      required this.slotId,
      required this.consultDate,
      required this.pinCode});
}
