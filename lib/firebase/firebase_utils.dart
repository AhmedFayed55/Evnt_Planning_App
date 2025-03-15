import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evnt_planning_app/model/event.dart';
import 'package:evnt_planning_app/utils/app_strings.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(AppStrings.collectionName)
        .withConverter<Event>(
            fromFirestore: (snapshot, options) =>
                Event.fromFireStore(snapshot.data()!),
            // snapshot is an object from document
            toFirestore: (event, _) => event.toFireStore());
  }

  static Future<void> addEventToFireStore(Event event) {
    CollectionReference<Event> collectionRef =
        getEventCollection(); // get or create collection
    DocumentReference<Event> docRef = collectionRef.doc(); // create document
    event.id = docRef.id; // auto id
    return docRef.set(event); // todo: Add event to document
  }
}
