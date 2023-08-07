
import 'package:intl/intl.dart';

String timeFormat12Hours = "hh:mm:ss a";
String dateFormatWithHalfMonthName = "dd MMM yyyy";
String dateFormatWithFullMonthName = "dd MMMM yyyy";


String convertDate({required DateTime yourDate,required String format}){
  final DateFormat formatter = DateFormat(format);
  return formatter.format(yourDate);
}

String convertTimeTo12Hours({required String time, required String format}){
  var dateTime = stringToTimeFormat(originalTime: time);
  String time12HourFormat = DateFormat(format).format(dateTime);
  return time12HourFormat;
}

DateTime stringToTimeFormat({String baseFormat = 'HH:mm:ss',required String originalTime}){
  return DateFormat(baseFormat).parse(originalTime);
}

DateTime stringToDateOnly({String baseFormat = 'dd-mm-yyyy',required String originalDate}){
  return DateFormat(baseFormat).parse(originalDate);
}

int differenceBetweenTwoDate({required DateTime statDate,required DateTime endDate}){
  return endDate.difference(statDate).inDays;
}