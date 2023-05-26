// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) => UserSettings(
      burnAfterReadingGroups:
          (json['burn_after_reading_groups'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as int),
      ),
      burnAfterReadingUsers:
          (json['burn_after_reading_users'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as int),
      ),
      muteGroups: (json['mute_groups'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as int),
      ),
      muteUsers: (json['mute_users'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as int),
      ),
      readIndexGroups: (json['read_index_groups'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as int),
      ),
      readIndexUsers: (json['read_index_users'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as int),
      ),
    );

Map<String, dynamic> _$UserSettingsToJson(UserSettings instance) =>
    <String, dynamic>{
      'burn_after_reading_groups': instance.burnAfterReadingGroups
          .map((k, e) => MapEntry(k.toString(), e)),
      'burn_after_reading_users': instance.burnAfterReadingUsers
          .map((k, e) => MapEntry(k.toString(), e)),
      'mute_groups':
          instance.muteGroups.map((k, e) => MapEntry(k.toString(), e)),
      'mute_users': instance.muteUsers.map((k, e) => MapEntry(k.toString(), e)),
      'read_index_groups':
          instance.readIndexGroups.map((k, e) => MapEntry(k.toString(), e)),
      'read_index_users':
          instance.readIndexUsers.map((k, e) => MapEntry(k.toString(), e)),
    };
