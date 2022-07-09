import 'dart:ffi';

import 'package:appstructure/Interface/Interface.dart';
import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/widgets_dir.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsListing extends StatefulWidget {
  const NewsListing({Key? key}) : super(key: key);

  @override
  State<NewsListing> createState() => _NewsListingState();
}

class _NewsListingState extends State<NewsListing> {
  final _searchController = TextEditingController();
  Interface interface = Interface();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: CustomColors.ColorWhite,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBarCustom(title: "News",isNews: true,),
            //searchBox()
            Padding(
              padding: EdgeInsets.only(left: Dimentions.widthMargin15),
              child: Text('Latest news of Maninagar Shree Swaminarayan Gadi',
                  style: Theme.of(context).textTheme.headline2),
            ),
            titleViewAll('Polular News'),
            Container(
              margin: EdgeInsets.only(top: Dimentions.heightMargin15),
              child: SizedBox(
                child: _horizontalList(5),
                height: 330.h,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: Dimentions.widthMargin20,
                  top: Dimentions.heightMargin20,
                  right: Dimentions.widthMargin20),
              child: Text(
                'Latest News'.toUpperCase(),
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: Dimentions.widthMargin15),
              child: SizedBox(
                child: _verticalList(5),
              ),
            ),
          ],
        ),
      )),
    );
  }

  ListView _verticalList(int n) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: n,
      separatorBuilder: (_, __) => Container(),
      itemBuilder: (context, int index) {
        return itemNews('', '', '', false);
      },
    );
  }

  ListView _horizontalList(int n) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: n,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, int index) {
        return itemNews('', '', '', true);
      },
    );
  }

  Widget itemNews(String title, String desc, String author, bool isPopular) {
    return Container(
      width: isPopular ? 350.w : MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
          left: Dimentions.widthMargin15,
          bottom: Dimentions.heightMargin10,
          top: !isPopular ? Dimentions.widthMargin10 : 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: CustomColors.ColorWhite,
            boxShadow: [
              BoxShadow(
                color: CustomColors.ColorBlack2.withOpacity(.04),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, Dimentions.widthMargin05),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                  child: Image.asset(
                    'assets/images/banner_dashboard.jpg',
                    height: 170.h,
                    width:
                        isPopular ? 350.w : MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: Dimentions.widthMargin30),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 43.w,
                      height: 60.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/date_bg.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '21',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: CustomColors.ColorWhite,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: Dimentions.heightMargin05),
                            child: Text(
                              'MAY',
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: CustomColors.ColorWhite,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            '2022',
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: CustomColors.ColorWhite,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: Dimentions.heightMargin20,
                  left: Dimentions.widthMargin15,
                  right: Dimentions.widthMargin15),
              child: Text(
                'Shree Kutchi Leva Patel Samaj',
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: Dimentions.heightMargin10,
                  left: Dimentions.widthMargin15,
                  right: Dimentions.widthMargin15),
              child: Text(
                'Merciful Lord Shree Swaminarayanbapa Swamibapa cannot bear the pain of',
                style: Theme.of(context).textTheme.button,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: Dimentions.heightMargin10,
                  left: Dimentions.widthMargin15,
                  bottom: isPopular ? 0 : Dimentions.heightMargin20,
                  right: Dimentions.widthMargin15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Shree Swaminarayan Mandir Nairobi',
                      style:
                          TextStyle(color: CustomColors.FontColorGray2, fontSize: 14.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Image.asset(
                    'assets/images/share.png',
                    color: CustomColors.OrangeColor,
                    height: Dimentions.widthMargin20,
                    width: Dimentions.widthMargin20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleViewAll(String title) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimentions.widthMargin15,
          top: Dimentions.heightMargin20,
          right: Dimentions.widthMargin15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.headline4,
          ),
          Row(
            children: [
              Text(
                'View All',
                style: Theme.of(context).textTheme.headline5,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: CustomColors.IconColor,
                size: 15.w,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Card(
      color: CustomColors.ColorWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            color: CustomColors.IconColor,
            size: Dimentions.widthMargin15,
          ),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search here',
            ),
            autofocus: true,
            controller: _searchController,
          ),
        ],
      ),
    );
  }
}
