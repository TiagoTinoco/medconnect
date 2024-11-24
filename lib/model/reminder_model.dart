class ReminderModel {
  final String specialtieName;
  final String dateTime;
  final String hoursTime;

  ReminderModel({
    required this.specialtieName,
    required this.dateTime,
    required this.hoursTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'specialtieName': specialtieName,
      'dateTime': dateTime,
      'hoursTime': hoursTime,
    };
  }

  factory ReminderModel.fromMap(Map<String, dynamic> data) {
    return ReminderModel(
      specialtieName: data['specialtieName'] ?? '',
      dateTime: data['dateTime'] ?? '',
      hoursTime: data['hoursTime'] ?? '',
    );
  }
}
