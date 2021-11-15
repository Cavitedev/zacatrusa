import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_service.dart';

final settingsControllerProvider = ChangeNotifierProvider(
    (_) => SettingsController(SettingsService())..loadSettings());

final settingsFontFamilyControllerProvider = Provider((ref) =>
    ref.watch(settingsControllerProvider.select((set) => set._fontFaimily)));

class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  final SettingsService _settingsService;

  bool isLoaded = false;

  Future<void> loadSettings() async {
    isLoaded = true;

    await _settingsService.init();
    _notifyQueryDowngradeWarning =
        _settingsService.notifyQueryDowngradeWarning();
    _fontFaimily = _settingsService.fontFamily();

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

  late String _fontFaimily;

  String get fontFaimily => _fontFaimily;

  Future<void> updateFontfamily(String? newFontFamily) async {
    if (newFontFamily == null) return;
    if (newFontFamily == fontFaimily) return;

    _fontFaimily = newFontFamily;

    notifyListeners();

    await _settingsService.updateFontFamily(_fontFaimily);
  }
}
