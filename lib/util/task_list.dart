
import 'package:flutter/material.dart';
import 'package:todo/util/todo_tiles.dart';

class TaskList extends StatelessWidget {
  final List toDoList;
  final List filteredList;
  final List incompleteToDoList;
  final void Function(BuildContext, int) deleteTask;
  final void Function(bool?, int) onChanged;

  const TaskList(
      {super.key,
      required this.toDoList,
      required this.filteredList,
      required this.incompleteToDoList,
      required this.deleteTask,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return toDoList.isEmpty
        ? const Center(
            child: Text(
              'Add a new Task',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 25,
              ),
            ),
          )
        : ListView.builder(
            itemCount: toDoList.length,
            itemBuilder: (context, index) {
              return (index == incompleteToDoList.length)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top:15),
                            child: Text('Completed',
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                        ),
                        ToDoTile(
                            taskName: filteredList[index][0],
                            taskstaus: filteredList[index][1],
                            deleteTask: (_) {
                              deleteTask(_, index);
                            },
                            onChanged: (value) {
                              onChanged(value, index);
                            })
                      ],
                    )
                  : ToDoTile(
                      taskName: filteredList[index][0],
                      taskstaus: filteredList[index][1],
                      deleteTask: (_) {
                        deleteTask(_, index);
                      },
                      onChanged: (value) {
                        onChanged(value, index);
                      });
            });
  }
}
