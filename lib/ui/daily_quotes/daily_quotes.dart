import 'package:appstructure/data/network/apis/daily_quotes/daily_quote_notifier.dart';
import 'package:appstructure/provider/theme_provider.dart';
import 'package:appstructure/ui/daily_quotes/daily_quote_detail.dart';
import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../utils/dimentions.dart';

class DailyQuotes extends StatefulWidget {
  const DailyQuotes({Key? key}) : super(key: key);

  @override
  _DailyQuotesState createState() => _DailyQuotesState();
}

class _DailyQuotesState extends State<DailyQuotes> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final data = Provider.of<DailyQuoteNotifier>(context, listen: false);
      data.fetchDailyQuoteData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dailyQuoteData = Provider.of<DailyQuoteNotifier>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: Dimentions.widthMargin05, right: Dimentions.widthMargin10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarCustom(
                title: 'daily_quotes'.tr,
                isBack: true,
                isFilter: false,
                isSearch: false,
                backCallback: () {
                  Navigator.of(context).pop(true);
                },
                filterCallBack: () {},
                searchCallBack: () {},
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: dailyQuoteData.dailyQuoteModel!.mainData!.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DailyQuoteDetail(
                                    quote: dailyQuoteData.dailyQuoteModel!.mainData!.data![index].desc.toString(),
                                    author: dailyQuoteData.dailyQuoteModel!.mainData!.data![index].author.toString()),
                              ));
                        },
                        child: cell('${dailyQuoteData.dailyQuoteModel!.mainData!.data![index].desc}',
                            '- ${dailyQuoteData.dailyQuoteModel!.mainData!.data![index].author}'),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cell(String quote, String from) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
        margin: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/daily_quote_bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(25.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.asset(
              'assets/images/starting_quote.png',
              width: 25.w,
              height: 18.h,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Image.asset(
                        alignment: AlignmentDirectional.centerStart,
                        'assets/images/standing_line_dq.png',
                        height: 20,
                        width: 10,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 50,
                    child: Text(
                      quote,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displaySmall!.apply(
                          fontFamily: 'Otomanopee One',
                          color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.80) : const Color(0xFF13161D)),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: CustomColors.OrangeColor,
                        size: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 50,
                    child: Text(from,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.60) : const Color(0xFF5B5D62))),
                  ),
                ],
              ),
            ),
            Container(
              alignment: AlignmentDirectional.bottomEnd,
              child: Image.asset(
                'assets/images/ending_quote_icon.png',
                width: 25.w,
                height: 18.h,
              ),
            )
          ]),
        ));
  }
}
