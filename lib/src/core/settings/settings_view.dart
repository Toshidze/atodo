import 'package:atodo/src/features/auth/presentation/UI/sign_in.dart';
import 'package:atodo/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UnAuthenticated) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const SignIn()),
                  (route) => false,
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              // Glue the SettingsController to the theme selection DropdownButton.
              //
              // When a user selects a theme from the dropdown list, the
              // SettingsController is updated, which rebuilds the MaterialApp.
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Тема',
                        style: TextStyle(fontSize: 20),
                      ),
                      const Spacer(),
                      DropdownButton<ThemeMode>(
                        // Read the selected themeMode from the controller
                        value: controller.themeMode,
                        // Call the updateThemeMode method any time the user selects a theme.
                        onChanged: controller.updateThemeMode,
                        items: const [
                          DropdownMenuItem(
                            value: ThemeMode.light,
                            child: Text('Светлая'),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.dark,
                            child: Text('Темная'),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    child: const Text('Выйти'),
                    onPressed: () {
                      context.read<AuthBloc>().add(SignOutRequested());
                    },
                  )
                ],
              ),
            )));
  }
}
//     ),
//   );
// }
// }
