import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class NotesModel extends ChangeNotifier {
  Box box;
  bool isReady = false;
  NotesModel() {
    Hive.openBox<String>('notes').then((value) {
      box = value;
      isReady = true;
      notifyListeners();
    });
  }

  String get content {
    if (box == null) {
      return '';
    }
    return box.get(0) ?? '';
  }

  set content(String data) {
    box.put(0, data);
  }
}
