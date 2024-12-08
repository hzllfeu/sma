class AppointmentModel {
  final int? id;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final String subject;
  final String title;
  final String speaker;
  final String groupClass;

  AppointmentModel({
    this.id,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.subject,
    required this.title,
    required this.speaker,
    required this.groupClass,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'location': location,
      'subject': subject,
      'title': title,
      'speaker': speaker,
      'groupClass': groupClass,
    };
  }

  static AppointmentModel fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'],
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      location: map['location'],
      subject: map['subject'],
      title: map['title'],
      speaker: map['speaker'],
      groupClass: map['group'],
    );
  }
}