import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskstaus;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext) deleteTask;

  const ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskstaus,
      required this.onChanged,
      required this.deleteTask});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
                onPressed: deleteTask,
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(8))
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).primaryColor,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(0, 1))
              ]),
          child: Row(
            children: [
              Checkbox(
                value: taskstaus,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              Flexible(
                child: Text(
                  taskName,
                  style: TextStyle(
                      decorationThickness: 2.5,
                      decoration: taskstaus
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
