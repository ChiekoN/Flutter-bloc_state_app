import 'package:uuid/uuid.dart';

class Todate {
  String? id;
  DateTime date;
  String title;
  String? memo;

  Todate({ 
    required this.date,
    required this.title,
    String? id,
    this.memo,
  }) : id = id ?? const Uuid().v4();

  // DateTime Object contains time. This getter returns a String which has only date (in the user's timezone)
  String get dateString => '${date.toLocal()}'.split(' ')[0];

  DateTime get dateOnly => DateTime(date.year, date.month, date.day);
}