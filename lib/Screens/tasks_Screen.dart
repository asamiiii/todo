import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Widgets/component.dart';
import 'package:todo/cubit/cubit.dart';

import '../cubit/states.dart';

class NewTasks extends StatelessWidget {
  //const NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: ((context, state) {}),
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          if (cubit.newtasks.isEmpty) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    "Tasks",
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                body: const Center(
                  child: Text(
                    "No Tasks !!",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ));
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Tasks",
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: ListView.separated(
                addAutomaticKeepAlives: true,
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                separatorBuilder: (BuildContext context, int index) =>
                    Deviders(),

                // Task Items
                shrinkWrap: true,
                itemBuilder: (context, index) => ListsOfTAsks(
                    AppCubit.get(context).newtasks[index], context),
                itemCount: AppCubit.get(context).newtasks.length,
              ),
            );
          }
        });
  }
}
