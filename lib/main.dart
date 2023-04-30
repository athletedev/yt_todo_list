import 'package:flutter/material.dart';
import 'package:flutter_academy_app/data/controllers/list_notifier.dart';
import 'package:flutter_academy_app/data/list_of_tasks.dart';
import 'package:flutter_academy_app/data/models/task.dart';
import 'package:flutter_academy_app/view/edit_task_page.dart';
import 'package:flutter_academy_app/view/widgets/dismiss_background.dart';
import 'package:flutter_academy_app/view/widgets/my_list_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Academy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: FirstWidget(
        listNotifier: ListNotifier(listOfTask),
      ),
    );
  }
}

class FirstWidget extends StatelessWidget {
  const FirstWidget({Key? key, required this.listNotifier}) : super(key: key);

  final ListNotifier listNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ValueListenableBuilder<List<Task>>(
            valueListenable: listNotifier,
            builder: (context, value, child) {
              return Column(
                children: [
                  Expanded(
                    child: value.isNotEmpty
                        ? ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Dismissible(
                                secondaryBackground: const DismisBackground(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                                background: const DismisBackground(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                ),
                                onDismissed: (direction) =>
                                    listNotifier.removeTask(value[index]),
                                key: ValueKey(value[index]),
                                child: MyListTile(
                                  task: value[index],
                                  listNotifier: listNotifier,
                                ),
                              ),
                            ),
                          )
                        : const Center(
                            child: Text(
                              'No tasks! Add your first task!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                  ),
                  ColoredBox(
                    color: Colors.indigo.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Done tasks: ${listNotifier.listOfDoneTask.length}')
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: listNotifier.listOfDoneTask.length,
                        itemBuilder: (context, index) {
                          return MyListTile(
                            disableOnTap: true,
                            task: listNotifier.listOfDoneTask[index],
                            listNotifier: listNotifier,
                          );
                        }),
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditTaskPage(listNotifier: listNotifier),
            ),
          );
        },
      ),
    );
  }
}
