import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/component.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class ArchiveTasks extends StatelessWidget {
  const ArchiveTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: ((context, state) {}),
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "archived Tasks",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: ListView.separated(
              addAutomaticKeepAlives: true,
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
              separatorBuilder: (BuildContext context, int index) => Deviders(),

              // Task Items
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  ListsOfTAsks(AppCubit.get(context).archive[index], context),
              itemCount: AppCubit.get(context).archive.length,
            ),
          );
        });
  }
}
