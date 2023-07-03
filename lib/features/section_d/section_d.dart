import 'package:flutter/material.dart';
import 'package:flutter_tips_and_tricks/widgets/common.dart';

@immutable
class SectionD extends StatefulWidget {
  const SectionD({super.key});

  @override
  State<SectionD> createState() => _SectionDState();
}

class _SectionDState extends State<SectionD> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 2.5,
        ),
        child: Center(
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('First Button')),
                verticalMargin16,
                ElevatedButton(onPressed: () {}, child: const Text('Second Button')),
                verticalMargin16,
                ElevatedButton(onPressed: () {}, child: const Text('Third Button')),
                verticalMargin16,
                ElevatedButton(onPressed: () {}, child: const Text('Forth Button')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
