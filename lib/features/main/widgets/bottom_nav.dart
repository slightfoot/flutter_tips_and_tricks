import 'package:flutter/material.dart';
import 'package:flutter_tips_and_tricks/widgets/common.dart';

@immutable
class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.sections,
  });

  final int selected;
  final ValueChanged<int> onChanged;
  final List<(String, WidgetBuilder)> sections;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BottomAppBar(
      padding: emptyPadding,
      elevation: 8.0,
      color: theme.secondaryHeaderColor,
      child: DefaultTextStyle(
        style: theme.textTheme.titleLarge!.copyWith(
          color: theme.colorScheme.onSecondaryContainer,
        ),
        child: Row(
          children: [
            for (final (index, (name, _)) in sections.indexed) //
              Expanded(
                child: Ink(
                  color: selected == index ? theme.primaryColorDark : Colors.transparent,
                  child: InkWell(
                    onTap: () => onChanged(index),
                    child: Padding(
                      padding: verticalPadding12,
                      child: Center(
                        child: Text(
                          name,
                          style: selected == index //
                              ? TextStyle(color: theme.colorScheme.onPrimary)
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
