import 'package:flutter/material.dart';

enum ListGrid {list, grid}

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
  @override
  Widget build(BuildContext context) {
    return const Text("list, grid");
    // TODO add right UI with callbacks on each button.
    // Change opacity on the one that is not selected
  }
}