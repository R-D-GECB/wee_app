import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class WorkspaceModal extends ChangeNotifier {
  Box box;
  WorkspaceModal() {
    Hive.openBox<Map>('workspace').then((value) {
      box = value;
      notifyListeners();
    });
  }

  void add(Map<String, String> item) {
    box.add(item);
    notifyListeners();
  }

  List get keys {
    if (box == null) {
      return [];
    } else {
      return List.from(box.keys);
    }
  }

  Map valueOf(String id) {
    return Map.from(box.get(int.parse(id)));
  }
}
