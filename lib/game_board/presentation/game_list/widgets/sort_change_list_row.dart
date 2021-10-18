import 'package:flutter/material.dart';

class SortChangeListRow extends StatelessWidget {
  const SortChangeListRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Sort"),
            Text("list, grid"),
          ],
        ),
      ),
    );
  }
}
