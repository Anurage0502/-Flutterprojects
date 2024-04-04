import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String username = "Niraj";
String pass = "1234";

dynamic todoDatabase;

// List Global due to one time initialization
List<ToDoModel> taskList = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  todoDatabase = openDatabase(
    join(await getDatabasesPath(), "ToDoDatabase.db"),
    version: 1,
    onCreate: (db, version) {
      db.execute('''CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        date TEXT,
        isTaskDone INT
      )''');
    },
  );
  taskList = await getValues();
  runApp(const MyApp());
  print(todoDatabase);
  print(taskList);
}

Future<void> insertIntoDatabase(ToDoModel obj) async {
  final localDB = await todoDatabase;

  await localDB.insert('tasks', obj.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);

  taskList = await getValues();
}

Future<void> deleteFromDatabase(ToDoModel obj) async {
  final localDB = await todoDatabase;

  await localDB.delete('tasks', where: 'id = ?', whereArgs: [obj.id]);
  taskList = await getValues();
}

Future<void> updateIntoDatabase(ToDoModel obj) async {
  final localDB = await todoDatabase;

  await localDB
      .update('tasks', obj.toMap(), where: 'id = ?', whereArgs: [obj.id]);

  taskList = await getValues();
}

Future<List<ToDoModel>> getValues() async {
  final localDB = await todoDatabase;

  List<Map<String, dynamic>> list = await localDB.query('tasks');

  return List.generate(list.length, (index) {
    return ToDoModel(
        id: list[index]['id'],
        title: list[index]['title'],
        description: list[index]['description'],
        date: list[index]['date'],
        isTaskDone: (list[index]['isTaskDone'] == 0) ? false : true);
  });
}

//  db.execute('''CREATE TABLE tasks(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         title TEXT,
//         description TEXT,
//         date TEXT,
//         isTaskDone INT
//       )''');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoListAdv(),
    );
  }
}

class ToDoListAdv extends StatefulWidget {
  const ToDoListAdv({super.key});

  @override
  State createState() => _ToDoListAdvState();
}

class _ToDoListAdvState extends State {
  TextEditingController titleController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> modalBottomSheet(bool doedit, [ToDoModel? toDoModelobj]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(30))),
        context: this.context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(
                height: 13,
              ),
              Text(
                "Create Task",
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: GoogleFonts.quicksand(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(89, 57, 241, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Enter Title",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(89, 57, 241, 1)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 244, 67, 54)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Description",
                      style: GoogleFonts.quicksand(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(89, 57, 241, 1),
                      ),
                    ),
                    const SizedBox(height: 3),
                    TextFormField(
                      controller: dataController,
                      decoration: InputDecoration(
                        hintText: "Enter Description",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(89, 57, 241, 1)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 244, 67, 54)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Date",
                      style: GoogleFonts.quicksand(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(89, 57, 241, 1),
                      ),
                    ),
                    const SizedBox(height: 3),
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Enter Date",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(89, 57, 241, 1)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 244, 67, 54)),
                        ),
                        suffixIcon: const Icon(Icons.date_range_rounded),
                      ),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1924),
                          lastDate: DateTime(2025),
                        );
                        String formatedDate =
                            DateFormat.yMMMd().format(pickeddate!);
                        setState(() {
                          dateController.text = formatedDate;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                width: 300,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                child: ElevatedButton(
                  onPressed: () {
                    doedit ? submit(doedit, toDoModelobj) : submit(doedit);
                    Navigator.of(context).pop();
                    print("in Submit>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                    print(taskList);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color.fromRGBO(89, 57, 241, 1)),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ]),
          );
        });
  }

  void submit(bool doedit, [ToDoModel? toDoModelobj]) async {
    if (titleController.text.trim().isNotEmpty &&
        dataController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (!doedit) {
        await insertIntoDatabase(ToDoModel(
          title: titleController.text.trim(),
          description: dataController.text.trim(),
          date: dateController.text.trim(),
          isTaskDone: false,
        ));
        setState(() {
          print(taskList);
          print("insubmitFunction>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
          print(todoDatabase);
        });
      } else {
        toDoModelobj!.date = dateController.text.trim();
        toDoModelobj.title = titleController.text.trim();
        toDoModelobj.description = dataController.text.trim();
        await updateIntoDatabase(toDoModelobj);
      }
    }
    clearController();
  }

  void clearController() {
    titleController.clear();
    dataController.clear();
    dateController.clear();
  }

  void removeTasks(ToDoModel toDoModelobj) async {
    await deleteFromDatabase(toDoModelobj);
    setState(() {});
  }

  void editTasks(ToDoModel toDoModelobj) async {
    titleController.text = toDoModelobj.title;
    dataController.text = toDoModelobj.description;
    dateController.text = toDoModelobj.date;
    await modalBottomSheet(true, toDoModelobj);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(111, 81, 255, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const SizedBox(width: 29),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning",
                      style: GoogleFonts.quicksand(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                    Text(
                      "Pathum",
                      style: GoogleFonts.quicksand(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 41),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(217, 217, 217, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: Column(children: [
                  const SizedBox(
                    height: 19,
                  ),
                  Text("Create To Do List",
                      style: GoogleFonts.quicksand(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          taskList = await getValues();
                          setState(() {});
                        },
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: taskList.length,
                            itemBuilder: (context, index) {
                              return Slidable(
                                closeOnScroll: true,
                                endActionPane: ActionPane(
                                    extentRatio: 0.2,
                                    motion: const DrawerMotion(),
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  editTasks(taskList[index]);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromRGBO(
                                                              89, 57, 241, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  removeTasks(taskList[index]);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromRGBO(
                                                              89, 57, 241, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                key: ValueKey(index),
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    border: Border.all(
                                      width: 0.5,
                                      color:
                                          const Color.fromRGBO(0, 0, 0, 0.05),
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 20,
                                          color: Color.fromRGBO(0, 0, 0, 0.13))
                                    ],
                                    borderRadius:
                                        const BorderRadius.all(Radius.zero),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Container(
                                              height: 60,
                                              width: 60,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    217, 217, 217, 1),
                                              ),
                                              child: Image.asset(
                                                'assets/Group 42.png',
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width: 240,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  taskList[index].title,
                                                  style: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                      color:
                                                          const Color.fromRGBO(
                                                              0, 0, 0, 1)),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  taskList[index].description,
                                                  style: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color:
                                                          const Color.fromRGBO(
                                                              0, 0, 0, 1)),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  taskList[index].date,
                                                  style: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color:
                                                          const Color.fromRGBO(
                                                              0, 0, 0, 1)),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                          Checkbox(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              activeColor: const Color.fromRGBO(
                                                  4, 189, 0, 1),
                                              value: taskList[index].isTaskDone,
                                              onChanged: (val) {
                                                setState(() {
                                                  if (taskList[index]
                                                      .isTaskDone) {
                                                    taskList[index].isTaskDone =
                                                        false;
                                                    setState(() {
                                                      updateIntoDatabase(
                                                          taskList[index]);
                                                    });
                                                  } else {
                                                    taskList[index].isTaskDone =
                                                        true;
                                                    setState(() {
                                                      updateIntoDatabase(
                                                          taskList[index]);
                                                    });
                                                  }
                                                });
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(89, 57, 241, 1),
        shape: const CircleBorder(side: BorderSide.none),
        onPressed: () async {
          clearController();
          await modalBottomSheet(false);
        },
        child: const Icon(
          Icons.add,
          size: 50,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}

class ToDoModel {
  int? id;
  String title;
  String description;
  String date;

  bool isTaskDone;

  ToDoModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isTaskDone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'date': date,
      'isTaskDone': (isTaskDone) ? 1 : 0
    };
  }
}
