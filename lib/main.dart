import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fritjaj/providers/theme_state_provider.dart';
import 'package:fritjaj/screens/home_screen.dart';
import 'package:fritjaj/themes/dark_theme.dart';
import 'package:fritjaj/themes/light_theme.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: FritjajApp()));
}

class FritjajApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomePage.id: (context) => HomePage(),
      },
      theme: Provider.of<ThemeProvider>(context).isDarkMode ? darkThemes : lightThemes,
      title: 'fritjaj',
      initialRoute: HomePage.id,
    );
  }
}
