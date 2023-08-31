import 'package:flutter_test/flutter_test.dart';
import 'package:tranquillo/keys.dart';
import 'common/common.dart';

void main() {
  const String email = String.fromEnvironment('EMAIL_REGISTER');
  const String password = String.fromEnvironment('PASSWORD');

  tearDown(() async {
    await Commands.deleteTestUser(email, password);
  });

  integrationTest(
    'registers new user in app',
    ($) async {
      await Commands.openApp($);

      await $(K.loginPageRegisterButton).tap();

      await $(K.registerEmailTextField).enterText(email);

      await $(K.registerPasswordlTextField).enterText(password);

      await $(K.registerRepeatPasswordlTextField).enterText(password);

      await $(K.registerButton).tap();

      await $(K.dictandoCreateNew).waitUntilVisible();
    },
  );
}
