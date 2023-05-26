// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:vocechat_client/app.dart';
import 'package:vocechat_client/dao/dao.dart';
import 'package:vocechat_client/dao/init_dao/properties_models/user_settings.dart';

class UserSettingsM with M {
  String value = "";

  UserSettingsM();

  UserSettingsM.item(value);

  UserSettingsM.fromUserSettingsMap(Map<String, dynamic> map) {
    UserSettings s = UserSettings.fromUserSettings(map);
    value = jsonEncode(s.toJson());
  }

  static UserSettingsM fromMap(Map<String, dynamic> map) {
    UserSettingsM m = UserSettingsM();
    if (map.containsKey(M.ID)) {
      m.id = map[M.ID];
    }
    if (map.containsKey(F_value)) {
      m.value = map[F_value];
    }
    if (map.containsKey(F_createdAt)) {
      m.createdAt = map[F_createdAt];
    }

    return m;
  }

  static const F_tableName = 'user_settings';
  static const F_value = 'value';
  static const F_createdAt = 'created_at';

  @override
  Map<String, Object> get values =>
      {UserSettingsM.F_value: value, UserSettingsM.F_createdAt: createdAt};

  static MMeta meta = MMeta.fromType(UserSettingsM, UserSettingsM.fromMap)
    ..tableName = F_tableName;
}

class UserSettingsDao extends Dao<UserSettingsM> {
  UserSettingsDao() {
    UserSettingsM.meta;
  }

  Future<UserSettingsM> addOrUpdate(UserSettingsM m) async {
    UserSettingsM old;
    final list = await super.list();
    if (list.isNotEmpty) {
      old = list.first;

      m.id = old.id;
      await super.update(m);
      App.logger.info("User settings updated. ${m.values}");
    } else {
      await super.add(m);
      App.logger.info("User settings added. ${m.values}");
    }
    return m;
  }

  Future<UserSettingsM> updateFromSse(Map<String, dynamic> map) async {
    UserSettingsM m = UserSettingsM.fromUserSettingsMap(map);
    return await addOrUpdate(m);
  }

  Future<UserSettings?> getUserSettings() async {
    final list = await super.list();
    if (list.isNotEmpty) {
      final m = list.first;
      final s = UserSettings.fromJson(jsonDecode(m.value));
      return s;
    }
    return null;
  }
}
