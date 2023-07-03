import 'package:flutter/material.dart';

@immutable
class SectionA extends StatefulWidget {
  const SectionA({super.key});

  @override
  State<SectionA> createState() => _SectionAState();
}

Stream<int> autoCounter() => Stream.periodic(const Duration(seconds: 1), (el) => el + 1).take(10);

class _SectionAState extends State<SectionA> {
  int _counter = 0;

  final _autoCounterStream = autoCounter();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        StreamBuilder(
          stream: _autoCounterStream,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Auto counter: ${snapshot.data}'),
                    Text('Normal counter: $_counter'),
                  ],
                ),
              );
            }
          },
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: () => setState(() => _counter++),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
