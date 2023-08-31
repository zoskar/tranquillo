import 'package:patrol/patrol.dart';
import 'package:tranquillo/keys.dart';
import 'package:tranquillo/presentation/browse_screen.dart';
import 'common/common.dart';

void main() {
  const String email = String.fromEnvironment('EMAIL_LOGIN');
  const String password = String.fromEnvironment('PASSWORD');

  integrationTest(
    'logs in into the app',
    ($) async {
      await Commands.openApp($);

      await $(K.loginTextField).enterText(email);

      await $(K.passwordTextField).enterText(password);

      await $(K.loginButton).scrollTo().tap();

      await $(BrowseScreen).waitUntilVisible();
    },
  );
}
