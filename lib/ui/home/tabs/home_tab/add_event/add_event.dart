import 'package:evnt_planning_app/custom_widgets/custom_elevated_button.dart';
import 'package:evnt_planning_app/custom_widgets/custom_text_field.dart';
import 'package:evnt_planning_app/ui/home/tabs/home_tab/add_event/custom_row_date_time.dart';
import 'package:evnt_planning_app/ui/home/tabs/home_tab/tab_event_widget.dart';
import 'package:evnt_planning_app/utils/app_colors.dart';
import 'package:evnt_planning_app/utils/app_styles.dart';
import 'package:evnt_planning_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  static const String routeName = "Add_Even";

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController(); // title
  var descriptionController = TextEditingController(); // des
  DateTime? selectedDate;
  String formatedDate = ""; // date
  TimeOfDay? selectedTime;
  String formatedTime = ""; // time

  @override
  Widget build(BuildContext context) {
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    List<String> imageSelectedNameList = [
      AssetsManager.sport,
      AssetsManager.birthday,
      AssetsManager.meeting,
      AssetsManager.gaming,
      AssetsManager.workshop,
      AssetsManager.bookClub,
      AssetsManager.exhibition,
      AssetsManager.holiday,
      AssetsManager.eating,
    ];

    // Map<String, String> mapEventList = {
    //   AppLocalizations.of(context)!.sport: AssetsManager.sport,
    //   AppLocalizations.of(context)!.birthday: AssetsManager.birthday,
    //   AppLocalizations.of(context)!.meeting: AssetsManager.meeting,
    //   AppLocalizations.of(context)!.gaming: AssetsManager.gaming,
    //   AppLocalizations.of(context)!.workshop: AssetsManager.workshop,
    //   AppLocalizations.of(context)!.book_club: AssetsManager.bookClub,
    //   AppLocalizations.of(context)!.exhibition: AssetsManager.exhibition,
    //   AppLocalizations.of(context)!.holiday: AssetsManager.holiday1,
    //   AppLocalizations.of(context)!.eating: AssetsManager.eating,
    // };

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        title: Text(
          AppLocalizations.of(context)!.create_event,
          style: AppStyles.medium16Primary,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * .04, vertical: height * .01),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width * .9285,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    // mapEventList[eventsNameList[selectedIndex]]!,
                    imageSelectedNameList[selectedIndex],
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Container(
                  height: height * .055,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            selectedIndex = index;
                            setState(() {});
                          },
                          child: TabEventWidget(
                              borderColor: AppColors.primaryLight,
                              backgroundColor: AppColors.primaryLight,
                              textSelectedStyle: AppStyles.medium16White,
                              textUnSelectedStyle: AppStyles.medium16Primary,
                              eventName: eventsNameList[index],
                              isSelected: selectedIndex == index),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: width * .02,
                        );
                      },
                      itemCount: eventsNameList.length),
                ),
                SizedBox(
                  height: height * .013,
                ),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: AppStyles.medium16Black,
                ),
                SizedBox(
                  height: height * .013,
                ),
                CustomTextField(
                  controller: titleController,
                  prefixIcon: Icon(
                    Icons.edit_note_rounded,
                    size: 25,
                  ),
                  hintText: AppLocalizations.of(context)!.event_title,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!
                          .please_enter_a_title; // invalid
                    }
                    return null; // valid
                  },
                ),
                SizedBox(
                  height: height * .013,
                ),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: AppStyles.medium16Black,
                ),
                SizedBox(
                  height: height * .013,
                ),
                CustomTextField(
                  controller: descriptionController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!
                          .please_enter_a_title; // invalid
                    }
                    return null; // valid
                  },
                  maxLines: 4,
                  hintText: AppLocalizations.of(context)!.event_description,
                ),
                SizedBox(
                  height: height * .013,
                ),
                CustomRowDateTime(
                    chooseDateOrTime: chooseDate,
                    icon: Icon(Icons.date_range),
                    text: AppLocalizations.of(context)!.event_date,
                    textButton: selectedDate == null
                        ? AppLocalizations.of(context)!.choose_date
                        : formatedDate
                    // "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                    ),
                CustomRowDateTime(
                    chooseDateOrTime: chooseTime,
                    icon: Icon(Icons.access_time),
                    text: AppLocalizations.of(context)!.event_time,
                    textButton: selectedTime == null
                        ? AppLocalizations.of(context)!.choose_time
                        : formatedTime),
                Text(
                  AppLocalizations.of(context)!.location,
                  style: AppStyles.medium16Black,
                ),
                SizedBox(
                  height: height * .007,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: height * .008, horizontal: width * .017),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primaryLight)),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * .032, vertical: height * .017),
                        decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.asset(AssetsManager.gpsIcon),
                      ),
                      SizedBox(
                        width: width * .02,
                      ),
                      Text(
                        AppLocalizations.of(context)!.choose_event_location,
                        style: AppStyles.medium16Primary,
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.primaryLight,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .015,
                ),
                CustomElevatedButton(
                    text: AppLocalizations.of(context)!.add_event,
                    onTap: addEvent)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addEvent() {
    if (formKey.currentState?.validate() == true) {
      // todo : Add event
    }
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
        initialDate: DateTime.now(),
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate = chooseDate;
    formatedDate = DateFormat("dd/MM/yyyy").format(selectedDate!);
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    selectedTime = chooseTime;
    formatedTime = selectedTime!.format(context);
    setState(() {});
  }
}
