import 'package:flutter/material.dart';
import 'package:flutter_academy_app/data/controllers/list_notifier.dart';
import 'package:flutter_academy_app/data/models/task.dart';
import 'package:flutter_academy_app/data/models/task_priority.dart';
import 'package:flutter_academy_app/utils/colors.dart';
import 'package:flutter_academy_app/view/widgets/color_picker.dart';
import 'package:flutter_academy_app/view/widgets/dropdown_priority_picker.dart';
import 'package:flutter_academy_app/view/widgets/title_textfield.dart';
import 'package:uuid/uuid.dart';

class EditTaskPage extends StatelessWidget {
  EditTaskPage({super.key, required this.listNotifier, this.task});

  final Task? task;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final ListNotifier listNotifier;
  final ValueNotifier<Color> colorNotifier = ValueNotifier(Colors.white);
  final ValueNotifier<TaskPriority> priorityNotifier =
      ValueNotifier(TaskPriority.high);

  final ValueNotifier<String?> errorTextFieldNotifier = ValueNotifier(null);

  String? errorText;

  TextEditingController setTitleController(Task? task) {
    if (task == null) return titleController;
    titleController.text = task.title;
    return titleController;
  }

  TextEditingController setSubtitleController(Task? task) {
    if (task == null) return descController;
    descController.text = task.subtitile ?? '';
    return descController;
  }

  ValueNotifier<TaskPriority> setPriorityNotifier(Task? task) {
    if (task == null) return priorityNotifier;
    priorityNotifier.value = task.taskPriority;
    return priorityNotifier;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(children: [
            const Text('Task Name'),
            const SizedBox(
              height: 10,
            ),
            TitleTextField(
              setController: setTitleController(task),
              errorTextNotifier: errorTextFieldNotifier,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Task description'),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: setSubtitleController(task),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 14,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            ColorPicker(
              colorNotifier: colorNotifier,
              task: task,
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownPriorityPicker(
              priorityNotifier: setPriorityNotifier(task),
              initialDropdownValue: task?.taskPriority,
            ),
            const SizedBox(
              height: 20,
            ),
            if (task == null)
              MaterialButton(
                onPressed: () {
                  if (titleController.text.isEmpty) {
                    errorText = 'Please enter a title';
                    errorTextFieldNotifier.value = errorText ?? '';
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'At least the title of the task must be indicated!',
                        ),
                      ),
                    );
                    return;
                  }
                  listNotifier.addTask(
                    Task(
                      id: const Uuid().v4(),
                      color: colorNotifier.value,
                      title: titleController.text,
                      subtitile: descController.text,
                      taskPriority: priorityNotifier.value,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                color: Colors.red,
                child: const Text(
                  'Add Task',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            if (task != null)
              MaterialButton(
                onPressed: () {
                  listNotifier.updateTask(
                    task!.id,
                    task!.copyWith(
                      color: colorNotifier.value,
                      title: titleController.text,
                      subtitile: descController.text,
                      taskPriority: priorityNotifier.value,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                color: Colors.red,
                child: const Text(
                  'Update Task',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
