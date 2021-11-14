import 'package:flutter/material.dart';

class OfflineInfo extends StatelessWidget {
  final Function()? onReload;
  const OfflineInfo({Key? key, this.onReload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.signal_wifi_off_outlined),
            const Text("You're offline"),
            if (onReload != null)
              TextButton(
                onPressed: onReload,
                child: Row(
                  children: const [
                    Icon(
                      Icons.replay_outlined,
                      size: 18,
                    ),
                    Text(
                      "Reload",
                    )
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
