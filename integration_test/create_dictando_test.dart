import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tranquillo/data/classes.dart';
import 'package:tranquillo/keys.dart';
import 'package:tranquillo/presentation/widgets/dictando_tile.dart';
import 'common/common.dart';

void main() {
  const String email = String.fromEnvironment('EMAIL_LOGIN');
  const String password = String.fromEnvironment('PASSWORD');
  const String dictandoName = 'test_dictando';

  tearDown(() async {
    List<DictandoFromDatabase> userDictandos = [];

    final DatabaseReference dataRef = FirebaseDatabase.instance.ref();

    DataSnapshot response = await dataRef.child('dictandos').get();
    if (response.value != null) {
      final data =
          Map<String, dynamic>.from(response.value! as Map<Object?, Object?>);

      data.forEach((k, v) {
        userDictandos.add(
          DictandoFromDatabase(
            dictando: Dictando.parseDictando(v),
            id: k,
          ),
        );
      });

      String id = userDictandos
          .firstWhere((element) => element.dictando.name == dictandoName)
          .id;

      await dataRef
          .child('dictandos/$id')
          .remove()
          .then((_) => print('Deleted'))
          .catchError((error) => print('Delete failed: $error'));
    }
  });

  integrationTest(
    'creates new dictando',
    ($) async {
      await Commands.openApp($);

      await $(K.loginTextField).enterText(email);

      await $(K.passwordTextField).enterText(password);

      await $(K.loginButton).scrollTo().tap();

      await $(K.dictandoCreateNew).tap();

      await $(K.playPauseButton).tap();

      await $(K.songTile).tap();

      await $(K.stopButton).tap();

      await $(K.nextBarButton).tap();

      await $(K.saveButton).tap();

      await $(K.saveConfirmTextfield).enterText(dictandoName);

      await $(K.saveConfirmButton).tap();

      await $(DictandoTile).containing(dictandoName).waitUntilVisible();
    },
  );
}
