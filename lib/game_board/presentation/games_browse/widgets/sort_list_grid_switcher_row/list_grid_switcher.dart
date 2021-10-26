import 'package:flutter/material.dart';

enum ListGrid { list, grid }

class ListGridSwitcher extends StatefulWidget {
  const ListGridSwitcher({
    required this.onViewChange,
    Key? key,
  }) : super(key: key);

  final Function(ListGrid) onViewChange;

  @override
  State<ListGridSwitcher> createState() => _ListGridSwitcherState();
}

class _ListGridSwitcherState extends State<ListGridSwitcher> {
  ListGrid selected = ListGrid.list;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ViewSelectionButton(
          icon: Icons.list,
          onPressed: () {
            widget.onViewChange(ListGrid.list);
            setState(() {
              selected = ListGrid.list;
            });
          },
          selected: selected == ListGrid.list,
        ),
        ViewSelectionButton(
          icon: Icons.grid_view_sharp,
          onPressed: () {
            widget.onViewChange(ListGrid.grid);
            setState(() {
              selected = ListGrid.grid;
            });
          },
          selected: selected == ListGrid.grid,
        ),
      ],
    );
  }
}

class ViewSelectionButton extends StatelessWidget {
  const ViewSelectionButton(
      {Key? key,
      required this.onPressed,
      required this.icon,
      required this.selected})
      : super(key: key);

  final Function onPressed;
  final IconData icon;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 24,
      padding: EdgeInsets.zero,
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
