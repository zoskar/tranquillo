import 'package:tranquillo/keys.dart';

import 'common/common.dart';

void main() {
  integrationTest(
    'logs in into the app',
    ($) async {
      await Commands.openApp($);

      await $(K.loginButton).tap();

      await $.pump(const Duration(seconds: 10));
    },
  );
}
