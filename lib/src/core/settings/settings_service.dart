import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.

  Future<ThemeMode> themeMode() async {
    return await fetchThemeData().then((value) {
      if (value == 'light') {
        return ThemeMode.light;
      } else {
        return ThemeMode.dark;
      }
    }).catchError((onError) {});
  }

  Future<String> fetchThemeData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('themeMode').get();

    return snapshot.docs.first['theme'];
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('themeMode').doc('theme');

    Map<String, String> themeMode = {
      'theme': theme.name,
    };

    documentReference.set(themeMode);
  }
}
