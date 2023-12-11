import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit_database/Database/database.dart';
import 'package:todo_app_cubit_database/Database/taskmodel.dart';
import 'package:todo_app_cubit_database/cubit/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  DatabaseHelper db;
  TaskCubit({required this.db}) : super(InitialState());
  var titleController = TextEditingController();
  int iscompleted = 0;
  bool isupdate = false;

//events
  facthdata() async {
    emit(LoadedState(data: await db.fatchData()));
  }

  updateCheck(int id, bool comp) async {
    var compt = 0;
    if (comp == true) {
      compt = 1;
    } else {
      compt = 0;
    }

    db.updatecheck(id, compt);
    emit(LoadedState(data: await db.fatchData()));
  }

  createTask() async {
    var taskModel = await TaskModel(
        modelId: 0,
        modelTitle: titleController.text.toString(),
        modelCompleted: iscompleted);
    emit(LoadingState());
    var (check) = await db.createTask(taskModel);
    if (check) {
      emit(LoadedState(data: await db.fatchData()));
    } else {
      emit(ErrorState(erroMessage: 'Notes Not Added!!!!'));
    }
    titleController.clear();
  }

  updateTask(int id) async {
    isupdate = true;
    var taskmodel = await TaskModel(
        modelId: id,
        modelTitle: titleController.text.toString(),
        modelCompleted: iscompleted);
    emit(LoadingState());
    var check = await db.updateTask(taskmodel);
    if (check) {
      emit(LoadedState(data: await db.fatchData()));
    } else {
      emit(ErrorState(erroMessage: 'Task Not Update'));
    }
    titleController.clear();
  }

  updatedata(data) async {
    titleController.text = data;
  }

  deleteTask(int id) async {
    var check = await db.deleteTask(id);
    if (check) {
      emit(LoadedState(data: await db.fatchData()));
    } else {
      emit(ErrorState(erroMessage: 'Task Cannot Delete'));
    }
  }
}
