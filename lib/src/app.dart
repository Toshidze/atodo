import 'package:atodo/src/core/settings/settings_controller.dart';
import 'package:atodo/src/core/settings/settings_view.dart';
import 'package:atodo/src/features/home/presentation/widgets/todo_bottom_nav_bar.dart';
import 'package:atodo/src/features/auth/data/repository/auth_repository.dart';
import 'package:atodo/src/features/auth/presentation/UI/sign_in.dart';
import 'package:atodo/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:atodo/src/features/home/data/repository/todo_repository_impl.dart';
import 'package:atodo/src/features/home/presentation/bloc/todo_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;
  final repository = ToDoRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => ToDoRepositoryImpl(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) =>
                TodoBloc(todoRepository: repository)..add(const LoadTodo()),
          ),
        ],
        child: AnimatedBuilder(
          animation: settingsController,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              restorationScopeId: 'app',
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
              ],
              onGenerateTitle: (BuildContext context) =>
                  AppLocalizations.of(context)!.appTitle,
              theme: ThemeData(),
              darkTheme: ThemeData.dark(),
              themeMode: settingsController.themeMode,
              onGenerateRoute: (RouteSettings routeSettings) {
                return MaterialPageRoute<void>(
                  settings: routeSettings,
                  builder: (BuildContext context) {
                    switch (routeSettings.name) {
                      case SignIn.routeName:
                        return const SignIn();

                      case SettingsView.routeName:
                        return SettingsView(controller: settingsController);
                      default:
                        return StreamBuilder<User?>(
                            stream: FirebaseAuth.instance.authStateChanges(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return const TodoBottomNavBar();
                              }
                              return const SignIn();
                            });
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
