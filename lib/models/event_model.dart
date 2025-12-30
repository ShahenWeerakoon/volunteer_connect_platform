class EventModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime date;
  final String organizerId;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.organizerId,
  });

  factory EventModel.fromMap(String id, Map<String, dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'],
      description: data['description'],
      location: data['location'],
      date: DateTime.parse(data['date']),
      organizerId: data['organizerId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'date': date.toIso8601String(),
      'organizerId': organizerId,
      'createdAt': DateTime.now(),
    };
  }
}
