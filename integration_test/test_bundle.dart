// ignore_for_file: type=lint, invalid_use_of_internal_member

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

// START: GENERATED TEST IMPORTS
import 'create_dictando_test.dart' as create_dictando_test;
// END: GENERATED TEST IMPORTS

Future<void> main() async {
  final nativeAutomator = NativeAutomator(config: NativeAutomatorConfig());
  await nativeAutomator.initialize();
  PatrolBinding.ensureInitialized();

  // START: GENERATED TEST GROUPS
  group('create_dictando_test', create_dictando_test.main);
  // END: GENERATED TEST GROUPS
}
