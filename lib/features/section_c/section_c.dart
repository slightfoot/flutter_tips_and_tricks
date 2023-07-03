import 'package:flutter/material.dart';
import 'package:flutter_tips_and_tricks/models/user.dart';
import 'package:flutter_tips_and_tricks/widgets/common.dart';
import 'package:provider/provider.dart';

@immutable
class SectionC extends StatefulWidget {
  const SectionC({super.key});

  @override
  State<SectionC> createState() => _SectionCState();
}

class _SectionCState extends State<SectionC> {
  // late final user = Provider.of<User>(context);

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder(
    //   builder: (BuildContext context, BoxConstraints constraints) {
    //     return SizedBox(
    //       height: 100.0,
    //       child: ListView.builder(
    //         scrollDirection: Axis.horizontal,
    //         itemBuilder: (BuildContext context, int index) {
    //           return SizedBox(
    //             width: itemWidth,
    //             child: const Placeholder(),
    //           );
    //         },
    //       ),
    //     );
    //   },
    // ),
    return Material(
      child: Scrollbar(
        interactive: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 3.5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return const AspectRatio(
                      aspectRatio: 1.0,
                      child: Placeholder(),
                    );
                  },
                ),
              ),
              verticalMargin48 + verticalMargin48,
              IntrinsicWidth(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(onPressed: () {}, child: const Text('OK')),
                    ),
                    horizontalMargin16,
                    Expanded(
                      child: ElevatedButton(onPressed: () {}, child: const Text('Stornieren')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
