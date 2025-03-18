import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evnt_planning_app/utils/app_colors.dart';
import 'package:evnt_planning_app/utils/flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../firebase/firebase_utils.dart';
import '../model/event.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventsList = [];
  int selectedIndex = 0;
  List<String> eventsNameList = [];
  Map<String, String> toEnglishLocalizedMap = {};

  void getEventsNameList(BuildContext context) {
    eventsNameList = [
      AppLocalizations.of(context)!.all,
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
    toEnglishLocalizedMap = {
      AppLocalizations.of(context)!.all: "All",
      AppLocalizations.of(context)!.sport: "Sport",
      AppLocalizations.of(context)!.birthday: "Birthday",
      AppLocalizations.of(context)!.meeting: "Meeting",
      AppLocalizations.of(context)!.gaming: "Gaming",
      AppLocalizations.of(context)!.workshop: "Workshop",
      AppLocalizations.of(context)!.book_club: "Book Club",
      AppLocalizations.of(context)!.exhibition: "Exhibition",
      AppLocalizations.of(context)!.holiday: "Holiday",
      AppLocalizations.of(context)!.eating: "Eating"
    };
  }

  List<Event> filteredList = [];
  List<Event> favoriteEventsList = [];

  void getAllEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection().get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filteredList = eventsList;

    // todo : sorting
    filteredList.sort((Event event1, Event event2) {
      return event1.date.compareTo(event2.date);
    });

    notifyListeners();
  }

  void getFilteredEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection().get();
    //todo: get all events
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    String selectedCategory =
        toEnglishLocalizedMap[eventsNameList[selectedIndex]] ?? "";

    // todo : filter event list
    filteredList = eventsList.where((event) {
      return event.eventName == selectedCategory;
    }).toList();

    // todo : sorting
    filteredList.sort((Event event1, Event event2) {
      return event1.date.compareTo(event2.date);
    });

    notifyListeners();
  }

  void getFilteredEventsByFirebaseMethod() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection()
            .where('eventName', isEqualTo: eventsNameList[selectedIndex])
            .get();
    //todo: get all events
    filteredList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void updateFavoriteEvent(Event event) {
    FirebaseUtils.getEventCollection()
        .doc(event.id)
        .update({"isFavorite": !event.isFavorite}).timeout(
            Duration(milliseconds: 500), onTimeout: () {
      print("Event updated Successfully");
      ToastMessage.toastMsg(
          "Event Updated Successfully", Colors.green, AppColors.white);
      selectedIndex == 0 ? getAllEvents() : getFilteredEvents();
      getFavoriteEvents();
    });
    notifyListeners();
  }

  void getFavoriteEvents() async {
    // todo :  sort and filter by isFavorite then get in one line
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection()
            .orderBy("date")
            .where("isFavorite", isEqualTo: true)
            .get();
    favoriteEventsList = querySnapshot.docs.map((doc) {
      // convert a list of QueryDocumentSnapshot<Event> to list of events
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void changeSelectedIndex(newSelectedIndex) {
    selectedIndex = newSelectedIndex;
    if (selectedIndex == 0) {
      // todo: All
      getAllEvents();
    } else {
      getFilteredEvents();
    }
  }
}
