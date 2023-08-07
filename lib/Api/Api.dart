//Home Page Api
import 'package:healthcare2050/Api/Url.dart';

//Home Page Api
String categoryApi = "$port" + ipaddress + "/public/api/auth/category_fetch";
String getSubCategoryApi =
    "$port" + ipaddress + "/public/api/auth/ServiceCategotyWiseSubcategory";
String subCategoryDetailsApi =
    "$port" + ipaddress + "/public/api/auth/SubCategoryDetails";
String service_city_api =
    "$port" + ipaddress + "/public/api/auth/city_details_fetch";
String doctorApi = "$port" + ipaddress + "/public/api/auth/doctor_fetch";

//Login Page Api
String entryMobileNoApi =
    "$port" + ipaddress + "/public/api/auth/WebsiteLoginUser";
String validOtpApi = "$port" + ipaddress + "/public/api/auth/ValidateOtp";

//Book a service Apis
String bookCodeApi =
    "$port" + ipaddress + "/public/api/auth/getBookCodeAsSubcategoty";
String bookAServiceApi = port + ipaddress + "/public/api/auth/Book_Insert";

//Our Presence api
String our_presence_area_api =
    "$port" + ipaddress + "/public/api/auth/ZoneFetch";
String zoneWiseStateApi =
    "$port" + ipaddress + "/public/api/auth/ZoneWiseStateFetch";
String stateWiseCityApi =
    "$port" + ipaddress + "/public/api/auth/ZoneWiseCityFetch";
String cityFacilitiesApi =
    "$port" + ipaddress + "/public/api/auth/CityWiseDataFetch";

//Video Consult
String specializationApi =
    "$port" + ipaddress + "/public/api/auth/SpecializationFetch";
String specializationWiseDoctorApi =
    "$port" + ipaddress + "/public/api/auth/SpecializationWiseDataFetch";
String DoctorSlotApi =
    "$port" + ipaddress + "/public/api/auth/ConsultTypeSlotVisibility";

String todayAppointmentsApi =
    "$port" + ipaddress + "/public/api/auth/PatientOnlineConsultationDataFetch";
String upcomingAppointmentsApi =
    "$port" + ipaddress + "/public/api/auth/UpcomingdoctorScheduleList";

String doctorAppointmentScheduleListApi =
    "$port" + ipaddress + "/public/api/auth/doctorScheduleList";

String bookDoctorAppointmentApi =
    "$port" + ipaddress + "/public/api/auth/InsertAppointmentConsult";
String callEndApi = "$port" + "$ipaddress/public/api/auth/PatientEndVideoCall";

//request a service
String reuestAserviceApi =
    "$port" + ipaddress + "/public/api/auth/requestaservice";

//book appointment
String CityNameApi =
    "$port" + ipaddress + "/public/api/auth/CityNameBookAppointment";
String cityBasedSpecializationApi =
    "$port" + ipaddress + "/public/api/auth/CityWiseSpecification";
String specializationBasedDoctorsApi =
    "$port" + ipaddress + "/public/api/auth/city_specialization_wise_doctor";
String offlineBookAppointmentApi =
    "$port" + ipaddress + "/public/api/auth/BookAppointmentWiseSlotVisibility";

//Razorpay
String oderIdApi = "$port" + ipaddress + "/public/api/auth/GetAnOrderId";
String goToRazorPayApi =
    "$port" + ipaddress + "/public/api/auth/GotoPaymentRazorpay";
String updateRazorPayApi =
    "$port" + ipaddress + "/public/api/auth/RazorpaymentIdUpdate";

//Profile
String profileImageUploadApi =
    "$port" + ipaddress + "/public/api/auth/UserImageUpload";
String profileEditApi =
    "$port" + ipaddress + "/public/api/auth/UserAllDataUpload";
// prescription view

String getPrescriptionApi =
    port + ipaddress + "/public/api/auth/prescriptionpdfShow";

// searches
String searchServiceApi = "$port$ipaddress/public/api/auth/headerSearch";
String searchInCitiesApi = "$port$ipaddress/public/api/auth/CityheaderSearch";
String searchDoctorApi = "$port$ipaddress/public/api/auth/doctorSearch";

// doctor review
String getFeedbackListApi = "$port$ipaddress/public/api/auth/FeedbackList";
String postDoctorReviewApi =
    "$port$ipaddress/public/api/auth/FeedBackOfPatient";

// google maps apis
String mapMarkersApi = "$port$ipaddress/public/api/auth/AddressForMap";

// active appointment

String onlineActiveAppointmentAPi = "$port$ipaddress/public/api/auth/CheckConsultationValidityOfPatient";
String reInsertAppointmentDetailsApi =
    "$port" + ipaddress + "/public/api/auth/RevisitInsertAppointmentConsult";
String activePaymentStatusUpdateAPi = "$port$ipaddress/public/api/auth/SevendaysRazorPayPaymentIdUpdate";
