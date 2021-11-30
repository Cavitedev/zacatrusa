import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ListGrid { list, grid }

final listGridViewProvider = StateProvider((_) => ListGrid.list);

class ListGridSwitcher extends ConsumerWidget {
  const ListGridSwitcher({
    Key? key,
  }) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    final listGrid = ref.watch(listGridViewProvider);
    return Row(
      children: [
        ViewSelectionButton(
          icon: Icons.list,
          onPressed: () {
            ref.read(listGridViewProvider.notifier).state = ListGrid.list;
          },
          selected: listGrid == ListGrid.list,
          tooltip: "Vista en lista",
        ),
        ViewSelectionButton(
          icon: Icons.grid_view_sharp,
          onPressed: () {
            ref.read(listGridViewProvider.notifier).state = ListGrid.grid;
          },
          selected: listGrid == ListGrid.grid,
          tooltip: "Vista en grid",
        ),
      ],
    );
  }
}

class ViewSelectionButton extends StatelessWidget {
  const ViewSelectionButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.selected,
    required this.tooltip,
  }) : super(key: key);

  final Function onPressed;
  final IconData icon;
  final bool selected;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 24,
      padding: EdgeInsets.zero,
      tooltip: tooltip,
      icon: Container(
        padding: const EdgeInsets.all(4),
        child: Icon(icon),
        decoration: selected
            ? BoxDecoration(
                color: Colors.grey[350],
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              )
            : null,
      ),
      onPressed: () {
        onPressed();
      },
    );
  }
}
