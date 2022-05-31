import 'dart:async';
import 'dart:developer';

import 'package:atodo/src/core/settings/settings_service.dart';
import 'package:atodo/src/features/home/presentation/widgets/todo_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/app.dart';
import 'src/core/settings/settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(MyApp(settingsController: settingsController)),
        blocObserver: TodoBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
