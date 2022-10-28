class Schedule {
  int? id;
  String? title;
  String? description;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Schedule({
    this.id,
    this.title,
    this.description,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['isCompleted'] = isCompleted;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['color'] = color;
    data['remind'] = remind;
    data['repeat'] = repeat;

    return data;
  }
}