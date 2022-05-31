import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateTheme extends StatefulWidget {
  const UpdateTheme({Key? key}) : super(key: key);

  @override
  State<UpdateTheme> createState() => _UpdateThemeState();
}

class _UpdateThemeState extends State<UpdateTheme> {
  Future<void> updateThemeMode(ThemeMode theme) async {
    Map<String, String> todoList = {
      'theme': theme.name,
    };
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('atodo')
        .doc(theme.name.toString());

    documentReference.set(todoList).whenComplete(() => print('тема обновлена'));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
