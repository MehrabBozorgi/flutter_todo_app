import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_todo/model/user_model.dart';
import 'package:flutter_todo/theme/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/show_screen.dart';

void main() async {
  await Hive.initFlutter();
  // await Hive.openBox('testBox');

  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('userBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        // Locale('en'),
        Locale('fa'),
      ],
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.darkTheme,
      home: const ShowScreen(),
    );
  }
}
