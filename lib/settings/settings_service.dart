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

  static String fontFamilyKey = "font_family";

  String fontFamily() {
    return preferences.getString(fontFamilyKey) ?? "Roboto";
  }

  Future<void> updateFontFamily(String newFontFamily) async {
    await preferences.setString(fontFamilyKey, newFontFamily);
  }

  static String fontSizeKey = "font_size";

  double? fontSize() {
    return preferences.getDouble(fontSizeKey);
  }

  Future<void> updateFontSize(double? newFontSize) async {
    if (newFontSize == null) {
      await preferences.remove(fontSizeKey);
    } else {
      await preferences.setDouble(fontSizeKey, newFontSize);
    }
  }

  static String primaryColorIndexKey = "primary_color";
  static const int greenColorIndex = 9;

  int primaryColorIndex() {
    return preferences.getInt(primaryColorIndexKey) ?? greenColorIndex;
  }

  Future<void> updatePrimaryColorIndex(int newPrimaryColorIndex) async {
    await preferences.setInt(primaryColorIndexKey, newPrimaryColorIndex);
  }
}
