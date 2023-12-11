// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit_database/Database/colors.dart';
import 'package:todo_app_cubit_database/Screens/addNotes.dart';
import 'package:todo_app_cubit_database/cubit/task_cubit.dart';
import 'package:todo_app_cubit_database/cubit/task_state.dart';

class ToDo_Screen extends StatelessWidget {
  const ToDo_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TaskCubit>().facthdata();
    return Scaffold(
      backgroundColor: UiColors.shade100,
      appBar: AppBar(
        backgroundColor: UiColors.shade100,
        title: const Text("To-Do App"),
        actions: [
          TextButton(
              onPressed: () {
                context.read<TaskCubit>().isupdate = false;
                openBottomSheet(context, 0);
              },
              style: TextButton.styleFrom(
                  backgroundColor: UiColors.shade200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: Text(
                'Add Task',
                style: TextStyle(fontSize: 18, color: UiColors.shade700),
              )),
          SizedBox(width: 20)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return Center(
                        child:
                            Center(child: CircularProgressIndicator.adaptive()),
                      );
                    }
                    if (state is ErrorState) {
                      return Center(child: Text(state.erroMessage.toString()));
                    }
                    if (state is LoadedState) {
                      return notesList(state);
                    }
                    return SizedBox();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  ListView notesList(LoadedState state) {
    return ListView.builder(
        itemCount: state.data.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: UiColors.shade200,
                boxShadow: [
                  BoxShadow(
                      color: UiColors.black38, spreadRadius: 0.4, blurRadius: 1)
                ],
                borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 7),
              leading: SizedBox(
                width: 25,
                height: 25,
                child: Checkbox.adaptive(
                    activeColor: UiColors.shade700,
                    checkColor: UiColors.white,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: state.data[index].modelCompleted == 0 ? false : true,
                    onChanged: (value) {
                      context.read<TaskCubit>().updateCheck(
                            state.data[index].modelId,value!
                          );
                     
                    }),
              ),
              title: Row(
                children: [
                  Expanded(
                      child: Text(
                    '${state.data[index].modelTitle}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    width: 40,
                    // height: 40,
                    child: IconButton(
                        onPressed: () {
                          var path = context.read<TaskCubit>();
                          path.isupdate = true;
                          path.updatedata(state.data[index].modelTitle);

                          openBottomSheet(context, index);
                        },
                        icon: Icon(
                          Icons.edit_note_rounded,
                          size: 32,
                        )),
                  ),
                  SizedBox(
                    width: 40,
                    child: IconButton(
                        onPressed: () {
                          context
                              .read<TaskCubit>()
                              .deleteTask(state.data[index].modelId);
                        },
                        icon: Icon(CupertinoIcons.delete)),
                  ),
                ],
              ),
              // trailing:
            ),
          );
        });
  }
}
