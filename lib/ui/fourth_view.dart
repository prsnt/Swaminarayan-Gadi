import 'package:flutter/material.dart';

import '../constants/assets.dart';

class FourthView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Welcome',
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w900,
              )),
          const Text('To',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          const Text('Fourth View',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))
        ],
      ),
    );
  }
}
