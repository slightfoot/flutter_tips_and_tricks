import 'package:flutter/material.dart';

@immutable
class SectionB extends StatefulWidget {
  const SectionB({super.key});

  @override
  State<SectionB> createState() => _SectionBState();
}

class _SectionBState extends State<SectionB> {
  final _items = <String, Widget>{
    'item1': const Text('Item A'),
    'item2': const Text('Item B'),
    'item3': const Text('Item C'),
  };

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          for (final (i, MapEntry(key: k, value: v)) in _items.entries.indexed) //
            ListTile(
              key: Key(k),
              onTap: () => debugPrint('Tapped Item $i'),
              title: v,
              subtitle: Text('Description $i'),
            ),
        ],
      ),
    );
  }
}
