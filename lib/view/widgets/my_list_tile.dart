import 'package:flutter/material.dart';
import 'package:flutter_academy_app/data/controllers/list_notifier.dart';
import 'package:flutter_academy_app/data/models/task.dart';
import 'package:flutter_academy_app/view/edit_task_page.dart';
import 'package:uuid/uuid.dart';

class MyListTile extends StatefulWidget {
  const MyListTile({
    Key? key,
    required this.task,
    required this.listNotifier,
    this.disableOnTap = false,
  }) : super(key: key);

  final Task task;
  final ListNotifier listNotifier;
  final bool disableOnTap;

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    final checkboxValue = widget.task.isDone;

    return Column(
      children: [
        ColoredBox(
          color:
              !checkboxValue ? widget.task.color ?? Colors.white : Colors.grey,
          child: ListTile(
            leading: Checkbox(
              onChanged: (value) => setState(() {
                widget.listNotifier.toggleDone(widget.task);
              }),
              value: checkboxValue,
            ),
            title: Text(widget.task.title),
            subtitle: Text(widget.task.subtitile ?? ''),
            trailing: widget.task.taskPriority.icon,
            style: ListTileStyle.list,
            onTap: () => widget.disableOnTap
                ? null
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditTaskPage(
                        listNotifier: widget.listNotifier,
                        task: widget.task,
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
