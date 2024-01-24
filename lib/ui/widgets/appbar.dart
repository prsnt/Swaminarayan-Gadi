import 'package:appstructure/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';

// ignore: must_be_immutable
class AppBarCustom extends StatelessWidget {
  AppBarCustom(
      {Key? key,
      this.title,
      this.isBack,
      this.isSearch,
      this.isFilter,
      required this.backCallback,
      required this.filterCallBack,
      required this.searchCallBack})
      : super(key: key);

  final String? title;
  final bool? isBack;
  final bool? isSearch;
  final bool? isFilter;
  Function backCallback;
  Function filterCallBack;
  Function searchCallBack;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return FutureBuilder<String>(
      future: themeProvider.fetchTheme(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: Dimentions.widthMargin05, vertical: Dimentions.heightMargin05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: isBack!,
                      child: GestureDetector(
                        onTap: () {
                          backCallback();
                        },
                        child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: snapshot.data == 'Dark' ? const Color(0xFF262829) : const Color(0xFFFFFFFF),
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.08),
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            child: Image.asset(
                              'assets/images/back.png',
                              height: 20,
                              width: 20,
                              color: snapshot.data == 'Dark' ? const Color(0xFFDADADA) : const Color(0xFF373A40),
                            ),
                            padding: const EdgeInsets.all(10)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimentions.widthMargin10),
                      child: Text(title!, style: Theme.of(context).textTheme.displayMedium),
                    )
                  ],
                ),
                Row(
                  children: [
                    Visibility(
                      visible: isFilter!,
                      child: GestureDetector(
                        onTap: () {
                          filterCallBack();
                        },
                        child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: snapshot.data == 'Dark' ? const Color(0xFF262829) : const Color(0xFFFFFFFF),
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.08),
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            child: Icon(
                              Icons.filter_list,
                              size: 25,
                              color: snapshot.data == 'Dark' ? const Color(0xFFDADADA) : const Color(0xFF373A40),
                            )),
                      ),
                    ),
                    Visibility(
                      visible: isSearch!,
                      child: GestureDetector(
                        onTap: () {
                          searchCallBack();
                        },
                        child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: snapshot.data == 'Dark' ? const Color(0xFF262829) : const Color(0xFFFFFFFF),
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.08),
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            child: Icon(
                              Icons.search,
                              size: 25,
                              color: snapshot.data == 'Dark' ? const Color(0xFFDADADA) : const Color(0xFF373A40),
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
