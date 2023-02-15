import 'package:cache_manager/app/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static var shared = HiveHelper();

  static const userKey = "userKey";
  static const userBoxKey = "userBoxKey";

  Future<void> setupHive() async {
    await Hive.initFlutter();
    // Register TypeAdapters
    _initTypeAdapters();
    // Opening Boxes
    await _openBox();
  }

  Future<void> _openBox() async {
    await Hive.openBox<User>(userBoxKey);
  }

  void _initTypeAdapters() {
    Hive.registerAdapter(UserAdapter());
  }

  // CRUD Operations
  T? getData<T>({required String boxName, required dynamic key}) {
    var box = Hive.box<T>(boxName);
    return box.get(key);
  }

  Future<int> add<T>({required String boxName, required T data}) async {
    var box = Hive.box<T>(boxName);
    return await box.add(data);
  }

  Future<Iterable<int>> addAll<T>(
      {required String boxName, required List<T> list}) async {
    var box = Hive.box<T>(boxName);
    return await box.addAll(list);
  }

  Future<void> put<T>(
      {required String boxName,
      required dynamic data,
      required dynamic key}) async {
    var box = Hive.box<T>(boxName);
    await box.put(key, data);
  }

  Future<void> putAt<T>(
      {required String boxName,
      required int index,
      required dynamic value}) async {
    var box = Hive.box<T>(boxName);
    await box.putAt(index, value);
  }

  Future<void> delete<T>(
      {required String boxName, required dynamic key}) async {
    var box = Hive.box<T>(boxName);
    await box.delete(key);
  }

  Future<void> deleteAt<T>(
      {required String boxName, required int index}) async {
    var box = Hive.box<T>(boxName);
    await box.deleteAt(index);
  }

  List<T> getValues<T>({required String boxName}) {
    var box = Hive.box<T>(boxName);
    return box.values.toList();
  }

  List<dynamic> getKeys<T>({required String boxName}) {
    var box = Hive.box(boxName);
    return box.keys.toList();
  }

  ValueListenable<Box<T>> listenable<T>({required String boxName}) {
    var box = Hive.box<T>(boxName);
    return box.listenable();
  }

  Future<int> clear<T>({required String boxName}) {
    var box = Hive.box<T>(boxName);
    return box.clear();
  }

  bool containsKey<T>({required String boxName, dynamic key}) {
    var box = Hive.box<T>(boxName);
    return box.containsKey(key);
  }
}
