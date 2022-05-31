import 'package:atodo/src/core/settings/settings_view.dart';
import 'package:atodo/src/features/auth/presentation/UI/sign_in.dart';
import 'package:atodo/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:atodo/src/features/home/presentation/bloc/todo_bloc.dart';
import 'package:atodo/src/features/home/presentation/widgets/show_todo_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'todo_details_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var blocProvider = context.read<TodoBloc>();
    var firebaseCollection = FirebaseFirestore.instance.collection('atodo');
    return BlocListener<AuthBloc, AuthState>(listener: (context, state) {
      if (state is UnAuthenticated) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SignIn()),
          (route) => false,
        );
      }
    }, child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
      if (state is TodosLoading) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.blue,
            ),
          ),
        );
      } else {
        return StreamBuilder<QuerySnapshot>(
            stream: firebaseCollection
                .where('status', isEqualTo: 'new')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Add task');
              } else if (snapshot.hasData || snapshot.data != null) {
                var taskCounter = snapshot.data?.docs.length;
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.purple,
                    title: Text('Новые задачи ($taskCounter)'),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          Navigator.restorablePushNamed(
                              context, SettingsView.routeName);
                        },
                      ),
                    ],
                  ),
                  body: ListView.separated(
                    restorationId: 'homePage',
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 1,
                      );
                    },
                    itemCount: taskCounter!,
                    itemBuilder: (BuildContext context, int index) {
                      var documentSnapshot = snapshot.data?.docs[index];

                      return Slidable(
                        key: const ValueKey(1),
                        endActionPane: ActionPane(
                          extentRatio: 0.3,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                blocProvider
                                    .add(DeleteTodo(id: documentSnapshot!.id));
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Удалить',
                            ),
                          ],
                        ),
                        startActionPane: ActionPane(
                          extentRatio: 0.6,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                blocProvider.add(UpdateTodo('inProgress',
                                    id: documentSnapshot!.id));
                              },
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              icon: Icons.play_circle_outline_sharp,
                              label: 'В работу',
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                blocProvider.add(UpdateTodo('done',
                                    id: documentSnapshot!.id));
                              },
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              icon: Icons.task_alt_outlined,
                              label: 'Выполнено',
                            ),
                          ],
                        ),
                        child: ListTile(
                            title: Text((documentSnapshot != null)
                                ? (documentSnapshot['todoTitle'])
                                : ''),
                            subtitle: Text((documentSnapshot != null)
                                ? ((documentSnapshot['todoDesc'] != null)
                                    ? documentSnapshot['todoDesc']
                                    : '')
                                : ''),
                            trailing: Text((documentSnapshot != null)
                                ? ((documentSnapshot['date'] != null)
                                    ? documentSnapshot['date']
                                    : '')
                                : ''),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TodoDetailsView(
                                          title: documentSnapshot!['todoTitle'],
                                          description:
                                              documentSnapshot['todoDesc'],
                                          status: 'new',
                                          snapshot: documentSnapshot,
                                        )),
                              );
                            }),
                      );
                    },
                  ),
                  floatingActionButton: const ShowTodoDialog(),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue,
                  ),
                ),
              );
            });
      }
    }));
  }
}
