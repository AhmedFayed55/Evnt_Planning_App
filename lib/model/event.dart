class Event {
  // data class - model
  String id;
  String eventName;
  String title;
  String description;
  String image;
  DateTime date;
  String time;
  bool isFavorite;

  Event(
      {this.id = "",
      required this.eventName,
      required this.title,
      required this.description,
      required this.date,
      required this.time,
      required this.image,
      this.isFavorite = false});

  // todo: json => object
  Event.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?["id"] as String? ?? "",
          eventName: data?["eventName"] as String? ?? "No Name",
          title: data?["title"] as String? ?? "Untitled",
          description: data?["description"] as String? ?? "No Description",
          image: data?["image"] as String? ?? "",
          date: data?["date"] != null
              ? DateTime.fromMillisecondsSinceEpoch(data!["date"])
              : DateTime.now(),
          time: data?["time"] as String? ?? "00:00",
          isFavorite: data?["isFavorite"] as bool? ?? false,
        );

  /*
   Event.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data!["id"] as String,
          eventName: data["eventName"] as String,
          title: data["title"] as String,
          description: data["description"] as String,
          image: data["image"] as String,
          date: DateTime.fromMillisecondsSinceEpoch(data["date"]),
          // todo: return it to DateTime
          time: data["time"],
          isFavorite: data["isFavorite"] as bool,
        );
   */

  // todo: object => json
  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "eventName": eventName,
      "description": description,
      "image": image,
      "date": date.millisecondsSinceEpoch,
      // todo : save it as int => {and remember to return it}
      "time": time,
      "isFavorite": isFavorite,
    };
  }
}
