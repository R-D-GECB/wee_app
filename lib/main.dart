import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wee_app/data/archive_model.dart';
import 'package:wee_app/data/default_model.dart';
import 'package:wee_app/data/note_modal.dart';
import 'package:wee_app/data/workspace_model.dart';
import 'package:wee_app/views/about.dart';
import 'package:wee_app/views/archive.dart';
import 'package:wee_app/views/defaults.dart';
import 'package:wee_app/views/faq.dart';
import 'package:wee_app/views/form.dart';
import 'package:wee_app/views/notes.dart';
import 'package:wee_app/views/preview.dart';
import 'package:wee_app/views/processing.dart';
import 'package:wee_app/views/workspace.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  runApp(WEEApp());
}

class WEEApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WorkspaceModel()),
        ChangeNotifierProvider(create: (context) => DefaultsModel()),
        ChangeNotifierProvider(create: (context) => ArchiveModel()),
        ChangeNotifierProvider(create: (context) => NotesModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            accentColor: Colors.green[600],
            backgroundColor: Colors.grey[800],
            primaryColor: Colors.grey[850],
            primaryColorLight: Colors.grey[200],
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.green[600],
              selectionColor: Colors.green[600].withOpacity(0.5),
              selectionHandleColor: Colors.green[600],
            )),
        routes: {
          '/': (context) => WorkspaceView(),
          '/about': (context) => AboutView(),
          '/defaults': (context) => DefaultView(),
          '/archive': (context) => ArchiveView(),
          '/processing': (context) => ProcessingView(),
          '/preview': (context) => PreviewView(),
          '/faq': (context) => FaqView(),
          '/notes': (context) => NotesView(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/edit') {
            final args = settings.arguments;
            return MaterialPageRoute(builder: (context) {
              return FormView(data: args, editMode: true);
            });
          }
          if (settings.name == '/add') {
            final args = settings.arguments;
            return MaterialPageRoute(builder: (context) {
              return FormView(data: args);
            });
          }
          return null;
        },
      ),
    );
  }
}
