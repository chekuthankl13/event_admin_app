class EventArguments {
  final String id;
  final String title;
  final String date;
  final String location;
  final String description;
  final bool isCreate;

  EventArguments({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.description,
    this.isCreate = false,
  });
}
