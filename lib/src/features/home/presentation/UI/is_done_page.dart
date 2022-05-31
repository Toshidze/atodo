import 'package:atodo/src/core/settings/settings_view.dart';
import 'package:atodo/src/features/auth/presentation/UI/sign_in.dart';
import 'package:atodo/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'todo_details_view.dart';

class IsDonePage extends StatefulWidget {
  const IsDonePage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  State<IsDonePage> createState() => _IsDonePageState();
}

class _IsDonePageState extends State<IsDonePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SignIn()),
            (route) => false,
          );
        }
      },
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('atodo')
              .where('status', isEqualTo: 'done')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Add task');
            } else if (snapshot.hasData || snapshot.data != null) {
              var taskCounter = snapshot.data?.docs.length;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.green,
                  title: Text('Завершенные задачи ($taskCounter)'),
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
                    QueryDocumentSnapshot<Object?>? documentSnapshot =
                        snapshot.data?.docs[index];
                    return ListTile(
                        title: Text((documentSnapshot != null)
                            ? (documentSnapshot['todoTitle'])
                            : ''),
                        subtitle: Text((documentSnapshot != null)
                            ? ((documentSnapshot['todoDesc'] != null)
                                ? documentSnapshot['todoDesc']
                                : '')
                            : ''),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TodoDetailsView(
                                      title: documentSnapshot?['todoTitle'],
                                      description:
                                          documentSnapshot?['todoDesc'],
                                      status: 'done',
                                      snapshot: documentSnapshot,
                                    )),
                          );
                        });
                  },
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blue,
                ),
              ),
            );
          }),
    );
  }
}
