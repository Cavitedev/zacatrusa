import 'package:flutter_riverpod/flutter_riverpod.dart';

final zacatrusScrapperProvider = Provider((ref) => ZacatrusScapper(ref: ref));

class ZacatrusScapper {
  const ZacatrusScapper({
    required this.ref,
  });

  final ProviderRef ref;




}
