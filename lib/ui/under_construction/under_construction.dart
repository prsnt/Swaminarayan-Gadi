import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnderConstruction extends StatefulWidget {
  const UnderConstruction({Key? key}) : super(key: key);

  @override
  _UnderConstructionState createState() => _UnderConstructionState();
}

class _UnderConstructionState extends State<UnderConstruction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBarCustom(
              title: 'Work in progress',
              isBack: true,
              isFilter: false,
              isSearch: false,
              backCallback: () {
                Navigator.of(context).pop(true);
              },
              filterCallBack: () {},
              searchCallBack: () {},
            ),
            Image.asset('assets/images/under_construction.jpeg'),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Text(
                'This screen is under construction',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Center(
              child: Text(
                'We are working on it.',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
