import 'package:event_admin/features/event/domain/entity/event_entity.dart';

class EventEntityModel extends EventEntity {
  EventEntityModel({
    required super.id,
    required super.title,
    required super.date,
    required super.location,
    required super.description,
  });

  factory EventEntityModel.fromJson(Map<String, dynamic> json) =>
      EventEntityModel(
        id: json["id"].toString(),
        title: json["title"].toString(),
        date: json["date"].toString(),
        location: json["location"].toString(),
        description: json["description"].toString(),
      );

  Map<String, String> toJson() => {
    "title": title,
    "date": date,
    "location": location,
    "description": description,
  };

  factory EventEntityModel.fromEntity(EventEntity data) => EventEntityModel(
    id: data.id,
    title: data.title,
    date: data.date,
    location: data.location,
    description: data.description,
  );
}
