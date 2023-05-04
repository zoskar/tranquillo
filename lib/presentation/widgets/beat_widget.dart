import 'package:dict/presentation/widgets/beat_notes.dart';
import 'package:dict/presentation/widgets/staff.dart';
import 'package:flutter/material.dart';

class BeatWidget extends StatelessWidget {
  const BeatWidget({
    required this.mainScale,
    Key? key,
  }) : super(key: key);

  final double mainScale;

  @override
  Widget build(BuildContext context) => SizedBox(
        // 24: lines and spaces + 12: noteScale
        height: mainScale * 24 + 12 * mainScale,
        child: Stack(
          children: [
            // TODO(zoskar): change order
            BeatNotes(step: mainScale),
            Staff(distance: mainScale),
          ],
        ),
      );
}
