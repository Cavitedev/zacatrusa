import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:zacatrusa/constants/app_margins_and_sizes.dart';

class QRDialog extends StatelessWidget {
  const QRDialog({
    required this.qrContent,
    required this.websiteName,
    Key? key,
  }) : super(key: key);

  final String qrContent;
  final String websiteName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Link de $websiteName",
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: innerElementsPadding,
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: QrImage(
                data: qrContent,
                size: 200,
              ),
            ),
            const SizedBox(
              height: innerElementsPadding,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Atrás"),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
