import 'package:tranquillo/data/classes.dart';
import 'package:flutter/material.dart';

class StaticbarWidget extends StatelessWidget {
  const StaticbarWidget({
    required this.step,
    required this.bar,
    Key? key,
  }) : super(key: key);

  final double step;
  final Bar bar;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          for (var i = 0; i < bar.notes.length; i++)
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3 / bar.notes.length,
              child: Column(
                children: [
                  SizedBox(height: bar.notes[i].pitch * step),
                  Flexible(
                    child: Icon(
                      bar.notes[i].getNoteIcon(),
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
