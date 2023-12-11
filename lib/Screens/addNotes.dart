import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit_database/Database/colors.dart';
import 'package:todo_app_cubit_database/cubit/task_cubit.dart';
import 'package:todo_app_cubit_database/cubit/task_state.dart';

openBottomSheet(BuildContext context, int mindex) {
  return showModalBottomSheet(
      backgroundColor: UiColors.shade100,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              taskTextField(context),
              SizedBox(height: 10),
              BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is ErrorState) {
                    return Center(child: Text(state.erroMessage.toString()));
                  }
                  if (state is LoadedState) {
                    var path = context.read<TaskCubit>();
                    return save_update_Button(path, context, state, mindex);
                  }
                  return SizedBox();
                },
              )
            ],
          ),
        );
      });
}

TextField taskTextField(BuildContext context) {
  return TextField(
    controller: context.read<TaskCubit>().titleController,
    cursorColor: UiColors.shade700,
    style: TextStyle(fontSize: 18, color: UiColors.black),
    decoration: InputDecoration(
        fillColor: UiColors.shade200,
        filled: true,
        hintText: 'Type Task Here',
        hintStyle: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: UiColors.black38),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none)),
  );
}

TextButton save_update_Button(
    TaskCubit path, BuildContext context, LoadedState state, int mindex) {
  return TextButton(
      onPressed: () {
        if (path.isupdate) {
          context.read<TaskCubit>().updateTask(state.data[mindex].modelId);
        } else {
          path.createTask();
        }
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          backgroundColor: UiColors.shade200,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: Text(
        path.isupdate == false ? "Save" : 'Update',
        style: TextStyle(fontSize: 17, color: UiColors.black38),
      ));
}
