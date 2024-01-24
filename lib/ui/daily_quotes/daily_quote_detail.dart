import 'package:appstructure/provider/theme_provider.dart';
import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DailyQuoteDetail extends StatefulWidget {
  const DailyQuoteDetail({Key? key, required this.quote, required this.author}) : super(key: key);
  final String quote;
  final String author;

  @override
  _DailyQuoteDetailState createState() => _DailyQuoteDetailState();
}

class _DailyQuoteDetailState extends State<DailyQuoteDetail> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: Dimentions.widthMargin05, right: Dimentions.widthMargin10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarCustom(
                title: 'daily_quote_details'.tr,
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
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 50,
                            child: Text(
                              widget.quote,
                              style: Theme.of(context).textTheme.displaySmall!.apply(
                                  fontSizeDelta: 3.0,
                                  fontFamily: 'Otomanopee One',
                                  color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.80) : const Color(0xFF13161D)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('- ${widget.author}',
                                style: Theme.of(context).textTheme.headlineMedium!.apply(
                                    fontSizeDelta: 2.0,
                                    color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.60) : const Color(0xFF5B5D62))),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
