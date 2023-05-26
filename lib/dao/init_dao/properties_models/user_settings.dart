import 'package:json_annotation/json_annotation.dart';
import 'package:vocechat_client/app.dart';

part 'user_settings.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UserSettings {
  late final Map<int, int> burnAfterReadingGroups;
  late final Map<int, int> burnAfterReadingUsers;
  late final Map<int, int> muteGroups;
  late final Map<int, int> muteUsers;
  late final Map<int, int> readIndexGroups;
  late final Map<int, int> readIndexUsers;

  UserSettings(
      {required this.burnAfterReadingGroups,
      required this.burnAfterReadingUsers,
      required this.muteGroups,
      required this.muteUsers,
      required this.readIndexGroups,
      required this.readIndexUsers});

  UserSettings.fromUserSettings(Map<String, dynamic> userSettings) {
    burnAfterReadingGroups = _mapFromList(
        userSettings["burn_after_reading_groups"], "gid", "expires_in");

    burnAfterReadingUsers = _mapFromList(
        userSettings["burn_after_reading_users"], "uid", "expires_in");

    muteGroups = _mapFromList(userSettings["mute_groups"], "gid", "expired_at");
    muteUsers = _mapFromList(userSettings["mute_users"], "uid", "expired_at");
    readIndexGroups =
        _mapFromList(userSettings["read_index_groups"], "gid", "mid");
    readIndexUsers =
        _mapFromList(userSettings["read_index_users"], "uid", "mid");
  }

  Map<int, int> _mapFromList(
      List<dynamic> list, String keyName, String valueName) {
    final map = <int, int>{};

    try {
      for (final item in list) {
        map[item[keyName]] = item[valueName];
      }
    } catch (e) {
      App.logger.severe(e);
    }
    return map;
  }

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$UserSettingsToJson(this);
}
