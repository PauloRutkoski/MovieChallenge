import 'package:flutter/material.dart';
import 'package:paysmartchallenge/view/screens/upcoming_list_screen.dart';
import 'package:paysmartchallenge/view/utils/theme.dart';

void main() {
  runApp(const PaySmartChallenge());
}

class PaySmartChallenge extends StatelessWidget {
  const PaySmartChallenge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.getTheme(),
      debugShowCheckedModeBanner: false,
      home: const UpcomingListScreen(),
    );
  }
}
