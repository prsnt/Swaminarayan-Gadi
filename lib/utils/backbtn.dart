import 'package:flutter/widgets.dart';

class BackButton extends StatefulWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  _BackButtonState createState() => _BackButtonState();
}

class _BackButtonState extends State<BackButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset("assets/images/back_btn.png"),
    );
  }
}
