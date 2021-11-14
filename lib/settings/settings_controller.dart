import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_service.dart';

final settingsControllerProvider = ChangeNotifierProvider(
    (_) => SettingsController(SettingsService())..loadSettings());

class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  final SettingsService _settingsService;

  bool isLoaded = false;

  Future<void> loadSettings() async {
    isLoaded = true;

    await _settingsService.init();
    _notifyQueryDowngradeWarning =
        _settingsService.notifyQueryDowngradeWarning();

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
}
