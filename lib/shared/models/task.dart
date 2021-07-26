import 'package:flutter/cupertino.dart';

class Task {
  int id;
  bool completed;
  String description;
  DateTime executionTime;
  int performerId;
  int photoCount;
  int facilityId;

  Task({
    @required this.id,
    @required this.completed,
    @required this.description,
    @required this.executionTime,
    @required this.performerId,
    @required this.photoCount,
    @required this.facilityId,
  });

  factory Task.fromJson(json) {
    return Task(
      id: json['id'] as int,
      completed: json['completed'] as bool,
      description: json['description'] as String,
      executionTime: json['executionTime'] as DateTime,
      performerId: json['performerId'] as int,
      photoCount: json['photoCount'] as int,
      facilityId: json['facilityId'] as int,
    );
  }
}
