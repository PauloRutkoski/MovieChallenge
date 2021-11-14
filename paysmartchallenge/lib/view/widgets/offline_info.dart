import 'package:flutter/material.dart';

class OfflineInfo extends StatelessWidget {
  const OfflineInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.signal_wifi_off_outlined),
            Text("You're offline")
          ],
        ),
      ],
    );
  }
}
