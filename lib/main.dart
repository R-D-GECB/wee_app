import 'package:flutter/material.dart';
import 'package:wee_app/views/workspace.dart';

void main() {
  runApp(WEEApp());
}

class WEEApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WorkspaceView(),
    );
  }
}
