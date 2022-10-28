class Schedule {
  int id;
  String title;
  String description;
  int isCompleted;
  String date;
  String startTime;
  String endTime;
  int color;
  int remind;
  String repeat;

  Schedule({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.remind,
    required this.repeat,
  });
}