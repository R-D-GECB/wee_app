import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wee_app/data/workspace_model.dart';
import 'package:wee_app/views/about_us.dart';
import 'package:wee_app/views/form.dart';
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
    return ChangeNotifierProvider(
      create: (context) => WorkspaceModal(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            accentColor: Colors.green[600],
            backgroundColor: Colors.grey[800],
            primaryColor: Colors.grey[850],
            primaryColorLight: Colors.grey[200]),
        routes: {
          '/': (context) => WorkspaceView(),
          '/add': (context) => AddView(),
          '/about': (context) => AboutView()
        },
      ),
    );
  }
}
