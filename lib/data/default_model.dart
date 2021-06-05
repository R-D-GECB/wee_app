import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class DefaultsModel extends ChangeNotifier {
  Box box;
  bool label = false;
  DefaultsModel() {
    Hive.openBox<Map>('defaults').then((value) {
      box = value;
      label = box.get(1) == null ? false : box.get(1)['label'];
      notifyListeners();
    });
  }
  set labelNeeded(bool b) {
    label = b;
    box.put(1, {'label': b});
    notifyListeners();
  }

  Map get data {
    if (box == null) {
      return null;
    }
    return box.get(0) ?? {};
  }

  set data(Map data) {
    box.put(0, data);
    notifyListeners();
  }
}
