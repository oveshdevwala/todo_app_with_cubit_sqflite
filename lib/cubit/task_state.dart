import 'package:todo_app_cubit_database/Database/taskmodel.dart';

abstract class TaskState {}

class InitialState extends TaskState {}

class LoadingState extends TaskState {}

class LoadedState extends TaskState {
  List<TaskModel> data;

  LoadedState({required this.data});
}

class ErrorState extends TaskState {
  String erroMessage;
  ErrorState({required this.erroMessage});
  
}
