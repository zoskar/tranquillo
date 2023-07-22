import 'package:firebase_core/firebase_core.dart';
import 'package:patrol/patrol.dart';
import 'package:tranquillo/app.dart';

const nativeConfig = NativeAutomatorConfig(
  packageName: 'com.example.tranquillo',
  bundleId: 'com.example.tranquillo',
);

void integrationTest(
  String description,
  Future<void> Function(PatrolTester) callback,
) {
  patrolTest(
    description,
    callback,
    nativeAutomation: true,
    nativeAutomatorConfig: nativeConfig,
  );
}

abstract class Commands {
  static Future<void> openApp(PatrolTester $) async {
    await Firebase.initializeApp();

    await $.pumpWidgetAndSettle(const App());
  }
}
