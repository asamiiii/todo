import 'package:flutter/material.dart';
import "Done_Tasks.dart";
import 'archive_Screen.dart';
import 'package:todo/Widgets/component.dart';
import 'tasks_Screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class BottomScreen extends StatefulWidget {


   const BottomScreen({Key? key}) : super(key: key);

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  IconData iconn = Icons.edit;
  TextEditingController labelController =TextEditingController();
  TextEditingController timeController =TextEditingController();
  TextEditingController dateController =TextEditingController();
  late Database DB ;
  int CurIndex = 1 ;
  bool BottomSheetshown = false ;
  List<Widget> Cur_Screen = [
    const NewTasks(),
    const DoneTasks(),
    const ArchiveTasks(),
  ];
  var scafoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    creatDatabase();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          setState(() {

            if(BottomSheetshown){
              //iconn=Icons.edit;
              if(formKey.currentState!.validate()){
                insertToDatabase(
                    title:labelController.text,
                    date: dateController.text,
                    time: timeController.text
                ).then((value) => print(value));
                BottomSheetshown = false;
                //Navigator.pop(context);

              }}
            else
            {
              scafoldKey.currentState!.showBottomSheet((context) =>

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defultTextfeild(
                              mailController: labelController,
                              label: "Taske Tittle",
                              iconfeild: const Icon(Icons.title),
                              tapon: (){}
                          ),
                          const SizedBox(height: 10,),

                          defultTextfeild(
                            mailController: timeController,
                            label: "Time",
                            iconfeild: const Icon(Icons.lock_clock),
                            tapon: (){
                              showTimePicker(
                                  context: context,
                                  initialTime:TimeOfDay.now() )
                                  .then((value) {
                                timeController.text = value!.format(context).toString();
                                //print(value?.format(context).toString());
                              });
                            },
                            type: TextInputType.datetime,
                            readOnly: true,
                            //showCursor: true
                          ),
                          const SizedBox(height: 10,),

                          defultTextfeild(
                            mailController: dateController,
                            label: "Date",
                            iconfeild: const Icon(Icons.date_range),
                            tapon: (){
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.utc(2022,5,22),

                              )

                                  .then((value) {
                                // timeController = value?.format(context);
                                dateController.text=DateFormat.yMMMd().format(value!);
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
              ).closed.then((value){
                BottomSheetshown = false;
                //Navigator.pop(context);
                setState(() {
                  iconn=Icons.edit;
                });
              });
              BottomSheetshown = true;
              setState(() {
                iconn = Icons.add;
              });
            }
          });


        },
        child: Icon(iconn),
      ),


      body: Cur_Screen[CurIndex],
      bottomNavigationBar:
      BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        currentIndex: CurIndex,
        onTap: (index){
          setState(() {
            CurIndex = index ;
          });

          print(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_open_outlined),
               label: "Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.cloud_done_outlined),
              label: "Done"),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined),
              label: "Archive"),

        ],
      )
      ,
    );
  }

  void creatDatabase ()async{
     DB = await openDatabase("todoapp.db",
        version: 1,
        onCreate:(Database db,int version)async{
         await db.execute("CREATE TABLE Taskss (id INTEGER PRIMARY KEY,"
            " title TEXT,"
            " date TEXT,"
            " time TEXT ,"
            " status TEXT)"
        ).catchError((error){
          print("Error when creating Table ${error.toString()}");
        });
            print("Database Created");
        },
        onOpen:(database){
            //getFromDB(database);
            print("database opened");
        }
    );

  }

  Future<List <Map>> getFromDB (database)async{

    return await database.rawQuery("SELECT * from task");
    //print(tasks);

  }
  Future insertToDatabase(
    {
      required String title ,
      required String time ,
      required String date

    }

      )async{
    await DB.transaction((txn)async{
     await txn.rawInsert(""
         'Insert Into Taskss (title ,date,time,status) Values ("$title","$time","$date","NEW") ');
     print("Data inserted ");
   }).catchError((error){
     print("Error when Inserting Table ${error.toString()}");
   });
       return ;
  }
}
