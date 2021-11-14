import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  late final SharedPreferences preferences;

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static String notifyQueryDowngradeWarningKey =
      "notify_query_downgrade_warning";

  bool notifyQueryDowngradeWarning() {
    return preferences.getBool(notifyQueryDowngradeWarningKey) ?? false;
  }

  Future<void> updateNotifyQueryDowngradeWarning(bool notifyAgain) async {
    await preferences.setBool(notifyQueryDowngradeWarningKey, notifyAgain);
  }
}
