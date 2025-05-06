import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:patrol/patrol.dart';
import 'package:tranquillo/app.dart';

const nativeConfig = NativeAutomatorConfig(
  packageName: 'com.example.tranquillo',
  bundleId: 'com.example.tranquillo',
);

void integrationTest(
  String description,
  Future<void> Function(PatrolIntegrationTester) callback,
) {
  patrolTest(
    description,
    callback,
    nativeAutomatorConfig: nativeConfig,
  );
}

abstract class Commands {
  static Future<void> openApp(PatrolIntegrationTester $) async {
    await Firebase.initializeApp();

    await $.pumpWidgetAndSettle(const App());
  }

  static Future<void> deleteTestUser(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    // Logowanie użytkownika
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Usuwanie użytkownika
    await userCredential.user?.delete();
  }
}
