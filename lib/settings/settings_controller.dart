import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_service.dart';

final settingsControllerProvider =
    ChangeNotifierProvider((_) => SettingsController._singleton);

final settingsFontFamilyControllerProvider = Provider((ref) =>
    ref.watch(settingsControllerProvider.select((set) => set._fontFamily)));

final settingsFontSizeControllerProvider = Provider((ref) =>
    ref.watch(settingsControllerProvider.select((set) => set._fontSize)));

class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  final SettingsService _settingsService;

  static final SettingsController _singleton =
      SettingsController(SettingsService());

  factory SettingsController.singleton() => _singleton;

  bool isLoaded = false;

  Future<void> loadSettings() async {
    isLoaded = true;

    await _settingsService.init();
    _notifyQueryDowngradeWarning =
        _settingsService.notifyQueryDowngradeWarning();
    _fontFamily = _settingsService.fontFamily();
    _fontSize = _settingsService.fontSize();

    notifyListeners();
  }

  late bool _notifyQueryDowngradeWarning;

  bool get notifyQueryDowngradeWarning => _notifyQueryDowngradeWarning;

  Future<void> updateNotifyQueryDowngradeWarning(bool? notifyAgain) async {
    if (notifyAgain == null) return;
    if (notifyAgain == notifyQueryDowngradeWarning) return;

    _notifyQueryDowngradeWarning = notifyAgain;

    notifyListeners();

    await _settingsService
        .updateNotifyQueryDowngradeWarning(_notifyQueryDowngradeWarning);
  }

  late String _fontFamily;

  String get fontFamily => _fontFamily;

  Future<void> updateFontfamily(String? newFontFamily) async {
    if (newFontFamily == null) return;
    if (newFontFamily == fontFamily) return;

    _fontFamily = newFontFamily;

    notifyListeners();

    await _settingsService.updateFontFamily(_fontFamily);
  }

  double? _fontSize;

  double? get fontSize => _fontSize;

  Future<void> updateFontSize(double? newFontSize) async {
    if (newFontSize == fontSize) return;

    _fontSize = newFontSize;

    notifyListeners();

    await _settingsService.updateFontSize(_fontSize);
  }
}
