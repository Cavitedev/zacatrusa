import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({
    this.msg = "Loading...",
    Key? key,
  }) : super(key: key);

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
              width: 50, height: 50, child: CircularProgressIndicator()),
          Text(
            msg,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
