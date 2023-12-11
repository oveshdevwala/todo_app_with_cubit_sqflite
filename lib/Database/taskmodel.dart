import 'package:todo_app_cubit_database/Database/database.dart';

class TaskModel {
  int modelId;
  int modelCompleted;
  String modelTitle;

  TaskModel(
      {required this.modelId,
      required this.modelTitle,
      required this.modelCompleted});

  // fromMap
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
        modelId: map[DatabaseHelper.colId],
        modelTitle: map[DatabaseHelper.colTitle],
        modelCompleted: map[DatabaseHelper.colCompleted]);
  }

  Map<String, dynamic> toMap() {
    return {

      DatabaseHelper.colTitle : modelTitle,
      DatabaseHelper.colCompleted: modelCompleted
    };
  }
}
