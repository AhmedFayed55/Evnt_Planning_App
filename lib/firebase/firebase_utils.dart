import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evnt_planning_app/model/event.dart';
import 'package:evnt_planning_app/model/my_user.dart';
import 'package:evnt_planning_app/utils/app_strings.dart';

class FirebaseUtils {
  // for offline mode  => create collection for all events
  // static CollectionReference<Event> getEventCollection() {
  //   return FirebaseFirestore.instance
  //       .collection(AppStrings.collectionName)
  //       .withConverter<Event>(
  //           fromFirestore: (snapshot, options) =>
  //               Event.fromFireStore(snapshot.data()!),
  //           // snapshot is an object from document
  //           toFirestore: (event, _) => event.toFireStore());
  // }

  //todo: for online mode => create collection for events but inside the user collection
  // To specify each user's own events

  static CollectionReference<Event> getEventCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(AppStrings.collectionName)
        .withConverter<Event>(
            fromFirestore: (snapshot, options) =>
                Event.fromFireStore(snapshot.data()!),
            // snapshot is an object from document
            toFirestore: (event, _) => event.toFireStore());
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String id) async {
    DocumentSnapshot<MyUser> querySnapshot =
        await getUsersCollection().doc(id).get();
    return querySnapshot.data();
  }

  static Future<void> addEventToFireStore(Event event, String uId) {
    CollectionReference<Event> collectionRef =
        getEventCollection(uId); // get or create collection
    DocumentReference<Event> docRef = collectionRef.doc(); // create document
    event.id = docRef.id; // auto id
    return docRef.set(event); // todo: Add event to document
  }
}
