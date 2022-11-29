import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/util/new_task_dialog.dart';
import 'package:todo/util/task_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // text controller for new task
  final textcontroller = TextEditingController();

  // task list
  List toDoList = [];

  // newtask
  void newtask() {
    showDialog(
      context: context,
      builder: ((context) {
        textcontroller.clear();
        return NewTaskDialog(
            textController: textcontroller,
            save: onSave,
            cancel: () {
              Navigator.of(context).pop();
            });
      }),
    );
  }

  // save task in list
  void onSave() {
    if (textcontroller.text.isNotEmpty) {
      setState(() {
        toDoList.add([textcontroller.text, false]);
      });
      Navigator.of(context).pop();
    }
  }

  // reference of hive box
  final _mybox = Hive.box('mybox');

  // save data in box
  uploadList() {
    _mybox.put('list', toDoList);
  }

  @override
  void initState() {
    super.initState();
    final List? fetchList = _mybox.get('list');
    toDoList = fetchList ?? [];
  }

  @override
  Widget build(BuildContext context) {
    uploadList();

    final List incompleteToDoList =
        toDoList.where((element) => element[1] == false).toList();
    log('incompleted list $incompleteToDoList \n');
    final List completeToDoList =
        toDoList.where((element) => element[1] == true).toList();
    log('completed list $completeToDoList \n');
    final List filteredList = [...incompleteToDoList, ...completeToDoList];
    log('filted list $filteredList \n');

    // onchanged on click
    onChanged(bool? value, int index) {
      setState(() {
        toDoList[toDoList.indexOf(filteredList[index])][1] =
            !filteredList[index][1];
      });
    }

  // delete task from list
  deleteTask(BuildContext context, int index) {
    setState(() {
      toDoList.removeAt(toDoList.indexOf(filteredList[index]));
    });
  }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('TO DO'),
        actions: [
          toDoList.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      toDoList.clear();
                    });
                  },
                  icon: const Icon(
                    Icons.clear_all_rounded,
                    size: 40,
                  ))
              : const SizedBox(),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: TaskList(
        toDoList: toDoList,
        filteredList: filteredList,
        incompleteToDoList: incompleteToDoList,
        onChanged: onChanged,
        deleteTask: deleteTask,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: newtask, child: const Icon(Icons.add)),
    );
  }
}
