import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/states.dart';
import "Done_Tasks.dart";
import 'archive_Screen.dart';
import 'package:todo/Widgets/component.dart';
import 'tasks_Screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class BottomScreen extends StatelessWidget {
  //const BottomScreen({Key? key}) : super(key: key);

  TextEditingController labelController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  var scafoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  // @override
  //  void initState() {
  //    // TODO: implement initState
  //    super.initState();
  //    creatDatabase();
  //  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates states) {
          if (states is InsertDbState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates states) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scafoldKey,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.BottomSheetshown) {
                  cubit.iconn;
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: labelController.text,
                        date: timeController.text,
                        time: dateController.text);
                  }
                } else {
                  scafoldKey.currentState!
                      .showBottomSheet(
                        (context) => Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defultTextfeild(
                                    tfController: labelController,
                                    label: "Taske Tittle",
                                    iconfeild: const Icon(Icons.title),
                                    tapon: () {}),
                                const SizedBox(
                                  height: 10,
                                ),
                                defultTextfeild(
                                  tfController: timeController,
                                  label: "Time",
                                  iconfeild: const Icon(Icons.lock_clock),
                                  tapon: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                      //print(value?.format(context).toString());
                                    });
                                  },
                                  type: TextInputType.datetime,
                                  readOnly: true,
                                  //showCursor: true
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                defultTextfeild(
                                  tfController: dateController,
                                  label: "Date",
                                  iconfeild: const Icon(Icons.date_range),
                                  tapon: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.utc(2022, 5, 22),
                                    ).then((value) {
                                      // timeController = value?.format(context);
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                      print(DateFormat.yMMMd().format(value));
                                    });
                                  },
                                  type: TextInputType.datetime,
                                  readOnly: true,
                                  //showCursor: true
                                )
                              ],
                            ),
                          ),
                        ),
                        //enableDrag: false
                      )
                      .closed
                      .then((value) {
                    //BottomSheetshown = false;
                    //Navigator.pop(context);

                    cubit.bottomshown(false, Icons.edit);

                    labelController.clear();
                    timeController.clear();
                    dateController.clear();

                    //   iconn = Icons.edit;
                  });
                  //BottomSheetshown = true;

                  cubit.bottomshown(true, Icons.add);

                  //   iconn = Icons.add;

                }

                //RebuildTasks().addList(tasks[1]['date']);
              },
              child: Icon(cubit.iconn),
            ),
            body: /*tasks.isEmpty ?const Center(
                child: CircularProgressIndicator()):*/
                cubit.Cur_Screen[cubit.CurIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.blueGrey,
              currentIndex: cubit.CurIndex,
              onTap: (index) {
                // setState(() {
                cubit.changeIndex(index);

                // });

                print(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu_open_outlined), label: "Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.cloud_done_outlined), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: "Archive"),
              ],
            ),
          );
        },
      ),
    );
  }
}
