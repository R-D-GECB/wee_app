import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class WorkspaceModel extends ChangeNotifier {
  Box box;
  Timer timer;
  Set<String> selected = {};
  WorkspaceModel() {
    Hive.openBox<Map>('workspace').then((value) {
      box = value;
      notifyListeners();
    });
  }

  void add(Map item) {
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

  Map valueOf(String id, {bool d = false}) {
    Map response = Map.from(box.get(int.parse(id)));
    if (d) {
      delete(id);
    }
    return response;
  }

  void delete(String key) {
    box.delete(int.parse(key));
    selected.remove(key);
    notifyListeners();
  }

  void trash(String key) {
    if (timer != null) {
      confirmDelete();
    }
    Map temp = valueOf(key);
    delete(key);
    timer = Timer(Duration(seconds: 4), () {
      update(key, temp);
      timer = null;
    });
  }

  void confirmDelete() {
    timer.cancel();
    timer = null;
  }

  void update(String id, Map value) {
    box.put(int.parse(id), value);
    notifyListeners();
  }

  void select(String id) {
    selected.add(id);
    notifyListeners();
  }

  void deselect(String id) {
    selected.remove(id);
    notifyListeners();
  }

  bool get allSelected {
    return keys.length == selected.length && keys.length != 0;
  }

  void selectAllToggle() {
    if (allSelected) {
      selected.clear();
    } else {
      selected = Set.from(keys.map((e) => '$e'));
    }
    notifyListeners();
  }

  void deleteSelected() {
    List.from(selected).forEach((element) {
      delete(element);
    });
  }

  bool get alteastOneSelected {
    return selected.isNotEmpty;
  }

  List<Map> get selectedValues {
    List s = List.from(selected);
    return List<Map>.generate(selected.length, (index) => valueOf(s[index]));
  }
}
