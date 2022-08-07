import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_module.dart';

abstract class LocalPreferencesService {
  Future<bool> setString(String key, String value);

  bool containsKey(String key);

  String? getString(String key);

  void dispose();
}

class SharedPreferencesService implements LocalPreferencesService {
  final SharedPreferences instance;
  SharedPreferencesService({
    required this.instance,
  });

  static Future<SharedPreferencesService> getSharedPreferencesService({
    required SharedPreferences instance,
  }) async {
    await Modular.isModuleReady<AppModule>();
    return SharedPreferencesService(instance: instance);
  }

  @override
  Future<bool> setString(String key, String value) async =>
      await instance.setString(key, value);

  @override
  bool containsKey(String key) => instance.containsKey(key);

  @override
  String? getString(String key) => instance.getString(key);

  @override
  void dispose() {}
}
