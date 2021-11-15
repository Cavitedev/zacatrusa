import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_controller.dart';

class UpdatedMediaQuery extends ConsumerWidget {
  final Widget child;

  const UpdatedMediaQuery({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(
            textScaleFactor: ref.watch(settingsFontSizeControllerProvider)),
        child: child);
  }
}
