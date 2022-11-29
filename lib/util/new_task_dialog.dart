import 'package:flutter/material.dart';

class NewTaskDialog extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback save;
  final VoidCallback cancel;
  const NewTaskDialog({super.key,required this.textController,required this.save,required this.cancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amber[100],
      content: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             TextField(
              controller: textController,
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
              onSubmitted: (_){save();},
              decoration: const InputDecoration(
                hintText: 'Add a new task',
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: SizedBox(height: 50,
                      child: ElevatedButton(
                          onPressed: save, child: const Text('Save')),
                    )),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: SizedBox(height: 50,
                      child: ElevatedButton(
                          onPressed: cancel, child: const Text('cancel')),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
