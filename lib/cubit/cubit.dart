import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/cubit/states.dart';
import 'package:flutter/material.dart';

import '../Screens/Done_Tasks.dart';
import '../Screens/archive_Screen.dart';
import '../Screens/tasks_Screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(
      context); // to be more easily when call this cubit in many places

  int CurIndex = 1;
  List<Map> newtasks = [];
  List<Map> done = [];
  List<Map> archive = [];
  late Database DB;
  bool BottomSheetshown = false;
  IconData iconn = Icons.edit;

  void createDatabase() {
    // Craet a Local Database SqfLite
    openDatabase("todoapp.db", version: 1,
        onCreate: (Database db, int version) async {
      await db
          .execute("CREATE TABLE Taskss (id INTEGER PRIMARY KEY,"
              " title TEXT,"
              " date TEXT,"
              " time TEXT ,"
              " status TEXT)")
          .catchError((error) {
        print("Error when creating Table ${error.toString()}");
      });
      print("Database Created");
    }, onOpen: (db) {
      getFromDB(db);
      print("database opened");
    }).then((value) {
      DB = value;
      emit(CreateDbState());
    });
  }

  void getFromDB(Database db) async {
    // Get a Local Data From SqfLite Databse

    newtasks = [];
    done = [];
    archive = [];

    return await db.rawQuery('SELECT * FROM Taskss').then((value) {
      emit(GetFromDbState());
      value.forEach((element) {
        if (element['status'] == 'NEW') {
          newtasks.add(element);
        } else if (element['status'] == 'done') {
          done.add(element);
        } else {
          archive.add(element);
        }

        // print(element['status']);
      });
      //emit(GetFromDbState());

      //newtasks = value;

      print(newtasks);
    });
  }

  insertToDatabase(
      // Insert Date To Sqflite Database
      {required String title,
      required String time,
      required String date}) async {
    await DB.transaction((txn) {
      return txn.rawInsert(
          'Insert Into Taskss (title ,date,time,status) Values ("$title","$time","$date","NEW") ');
    }).then((value) {
      emit(InsertDbState());
      print("Data inserted ");

      getFromDB(DB);
    });

    return;
  }

  void updateDatabase(String? status, int? id) async {
    DB.rawUpdate('UPDATE Taskss SET status = ? WHERE id = ?',
        [status, id]).then((value) {
      getFromDB(DB);
      emit(UpdateDbState());
      //getFromDB(DB);
    });
  }

  void deleteFromDatabase(int? id) async {
    await DB.rawDelete('DELETE FROM Taskss WHERE id = ?', [id]);
    getFromDB(DB);
    emit(DeleteFromDbState());
    //getFromDB(DB);
  }

  void bottomshown(bool isShown, IconData icon) {
    //Togle Between edite Icon and Add Icon .
    BottomSheetshown = isShown;
    iconn = icon;
    emit(BottomShownState());
  }

  List<Widget> Cur_Screen = [
    //List Of Widgets , Contains a BottomNavBar Screens
    NewTasks(),
    DoneTasks(),
    ArchiveTasks(),
  ];

  int counter = 5; //Cubit Test Variable , For Me

  void minus() {
    //Cubit Test Method , For Me
    counter--;
    emit(CounterMinusState());
    print(counter);
  }

  void plus() {
    //Cubit Test Method , For Me
    counter++;
    emit(CounterPlusState());
  }

  void changeIndex(int index) {
    // Change Index Of BottomNavBar
    CurIndex = index;
    emit(AppBottomNavState());
  }
}
