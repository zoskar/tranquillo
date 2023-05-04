import 'package:tranquillo/data/classes.dart';
import 'package:flutter/material.dart';

class StaticBeatWidget extends StatelessWidget {
  const StaticBeatWidget({
    required this.step,
    required this.beat,
    Key? key,
  }) : super(key: key);

  final double step;
  final Beat beat;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          for (var i = 0; i < beat.notes.length; i++)
            SizedBox(
              width:
                  MediaQuery.of(context).size.width / 1.3 / beat.notes.length,
              child: Column(
                children: [
                  SizedBox(height: beat.notes[i].pitch * step),
                  Flexible(
                    child: Icon(
                      beat.notes[i].getNoteIcon(),
                      color: Colors.black,
                      size: 12 * step,
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
}
