import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class DefaultsModel extends ChangeNotifier {
  Box box;
  DefaultsModel() {
    Hive.openBox<Map>('defaults').then((value) {
      box = value;
      notifyListeners();
    });
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
