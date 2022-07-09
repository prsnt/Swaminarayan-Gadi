import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyDarshan extends StatefulWidget {
  const DailyDarshan({Key? key}) : super(key: key);

  @override
  State<DailyDarshan> createState() => _DailyDarshanState();
}

class _DailyDarshanState extends State<DailyDarshan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
              left: Dimentions.widthMargin05, right: Dimentions.widthMargin10),
          child: Column(
            children: [
              AppBarCustom(
                title: "Daily Darshan",
                isNews: false,
              ),
              Container(
                margin: EdgeInsets.only(top: Dimentions.heightMargin10),
                child: SizedBox(
                  child: _horizontalListDailyDarshanTitle(5),
                  height: 90.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView _horizontalListDailyDarshanTitle(int n) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: n,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, int index) {
        return itemDailyDarshanTitle('May 2022',index);
      },
    );
  }

  Widget itemDailyDarshanTitle(String title,int index) {
    return Container(
      height: 90.h,
      width: 100.w,
      child: Padding(
        padding: EdgeInsets.only(left: Dimentions.widthMargin15),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: index==0 ? AssetImage('assets/images/active.png') : AssetImage('assets/images/unactive_dailydarshan.png'),
            fit: BoxFit.fill,
          )),
          child: Padding(
            padding: EdgeInsets.only(bottom: Dimentions.heightMargin10),
            child: Center(
              child: Text(
                'Mangala Darshan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: index==0 ? CustomColors.ColorWhite : CustomColors.IconColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
