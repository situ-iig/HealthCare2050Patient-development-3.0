import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/active_appointments/active_appointment_model.dart';
import 'package:healthcare2050/utils/shapes/app_shapes.dart';
import 'package:healthcare2050/utils/styles/text_style.dart';
import 'package:healthcare2050/view/pages/active_booking/preview_active_appointment_screen.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../../Model/appointments/online/online_slot_available_model.dart';
import '../../../services/appointments/online_appointment_apis.dart';
import '../../../utils/colors.dart';
import '../../../utils/helpers/internet_helper.dart';

class AvailableSlotScreen extends StatefulWidget {
  final ActiveAppointmentModel data;
  final String consultType;
  final int days;

  const AvailableSlotScreen(
      {Key? key,
      required this.data,
      required this.consultType,
      required this.days})
      : super(key: key);

  @override
  State<AvailableSlotScreen> createState() => _AvailableSlotScreenState();
}

class _AvailableSlotScreenState extends State<AvailableSlotScreen> {
  DateTime currentDate = DateTime.now();
  var selectedDate = new DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (s) {});
    Provider.of<OnlineAvailableSlotProvider>(context, listen: false)
        .getOnlineSlots(
            selectedDate, widget.data.doctorId.toString(), widget.consultType);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        body: Column(
          children: [
            10.height,
            Text(
              "Select a time period",
              style: AppTextStyles.normalTextStyle(size: 16),
            ),
            _calenderView(),
            Divider(
              thickness: 2,
            ),
            Expanded(child: _showSlotsView(selectedDate))
          ],
        ),
      ),
    );
  }

  _calenderView() {
    return CalendarTimeline(
      showYears: false,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: currentDate.add(Duration(days: widget.days)),
      onDateSelected: (date) {
        var selectedDate = DateFormat('yyyy-MM-dd').format(date);
        setState(() => currentDate = date);
        getAvailableSlot(selectedDate);
      },
      leftMargin: 20,
      monthColor: textColor,
      dayColor: textColor,
      dayNameColor: Colors.white,
      activeDayColor: Colors.white,
      activeBackgroundDayColor: textColor,
      dotsColor: Colors.white,
      locale: 'en',
    );
  }

  Widget _showSlotsView(String date) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Consumer<OnlineAvailableSlotProvider>(
          builder: (c, value, child) {
            var slotList = value.slotList;
            return GridView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemCount: slotList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return slotList.isNotEmpty
                      ? _timeSlotView(slotList[index])
                      : _noSlotView().center();
                });
          },
        ));
  }

  getAvailableSlot(String date) {
    LoaderDialogView(context).showLoadingDialog();
    Provider.of<OnlineAvailableSlotProvider>(context, listen: false)
        .getOnlineSlots(
            date, widget.data.doctorId.toString(), widget.consultType)
        .then((value) {
      LoaderDialogView(context).dismissLoadingDialog();
    });
  }

  Widget _timeSlotView(OnlineAvailableSlotData data) {
    return InkWell(
      onTap: () {
        PreviewActiveAppointmentScreen(
                data: widget.data,
                consultType: widget.consultType,
                date: DateFormat('yyyy-MM-dd').format(currentDate),
                slotId: data.doctorAvailableId.toString(),
                slotTiming: "${data.startTime} - ${data.endTime}")
            .launch(context);
      },
      child: Card(
        shape: circularBorderShape(borderRadius: 5.0, borderColor: Colors.grey),
        child: Center(
            child: Text("${data.startTime} - ${data.endTime}").paddingAll(10)),
      ),
    );
  }

  Widget _noSlotView() {
    return Text("No Slots Available Now");
  }
}
