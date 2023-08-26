import 'package:firebase_storage/firebase_storage.dart';
import 'package:tranquillo/cubits/dictando_cubit.dart';
import 'package:tranquillo/cubits/file_cubit.dart';
import 'package:tranquillo/presentation/widgets/bar_widget.dart';
import 'package:tranquillo/presentation/widgets/carousel_widget.dart';
import 'package:tranquillo/presentation/widgets/keyboard.dart';
import 'package:tranquillo/presentation/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquillo/cubits/auth_cubit.dart';
import 'package:tranquillo/presentation/hamburger_menu.dart';

/// The screen that displays the dictando that is being created.
class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mainScale = MediaQuery.of(context).size.height / 90;
    double width = MediaQuery.of(context).size.width;

    if (context.read<DictandoCubit>().state is InitState) {
      context.read<DictandoCubit>().init();
    }

    return context.watch<AuthCubit>().state is AuthenticationInProgress
        ? const Scaffold(
            body: Center(child: Center(child: CircularProgressIndicator())),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: const HamburgerMenu(),
            appBar: const MyAppBar(),
            body: Column(
              children: [
                CarouselWidget(width: width, mainScale: mainScale),
                barWidget(mainScale: mainScale),
                const Keyboard(),
                BlocBuilder<FileCubit, FileCubitState>(
                  builder: (context, state) => Row(
                    children: [
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: state is Playing
                                ? const Icon(Icons.pause)
                                : const Icon(Icons.play_arrow),
                            onPressed: () async {
                              switch (state.runtimeType) {
                                case Playing:
                                  context.read<FileCubit>().pause();
                                  break;
                                case Paused:
                                  context.read<FileCubit>().play();
                                  break;
                                default:
                                  var files = await context
                                      .read<FileCubit>()
                                      .getFilesList();

                                  await showDialog<bool>(
                                    context: context,
                                    builder: (context) =>
                                        PickMusicDialog(files: files),
                                  );
                              }
                            },
                          ),
                          if (state is Playing || state is Paused)
                            IconButton(
                              icon: const Icon(Icons.stop),
                              onPressed: () {
                                context.read<FileCubit>().stop();
                              },
                            ),
                          if (state is Playing || state is Paused)
                            IconButton(
                              onPressed: () {
                                context.read<FileCubit>().replay();
                              },
                              icon: const Icon(Icons.replay),
                            ),
                          if (state is Playing || state is Paused)
                            IconButton(
                              onPressed: () {
                                context.read<FileCubit>().goBack();
                              },
                              icon: const Icon(Icons.replay_10),
                            ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}

class PickMusicDialog extends StatelessWidget {
  const PickMusicDialog({
    required this.files,
    Key? key,
  }) : super(key: key);

  final List<Reference> files;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Pick music'),
        content: SizedBox(
          width: 0,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: files.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                context
                    .read<FileCubit>()
                    .playFromUrl(url: files.elementAt(index).name);
                Navigator.pop(context, false);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  files.elementAt(index).name,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Cancel'),
          ),
        ],
      );
}
