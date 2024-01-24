import 'dart:developer';

import 'package:appstructure/bottombar/bottom_footer_navigation.dart';
import 'package:appstructure/data/network/apis/ghanshyam_vijay/ghanshyam_vijay_filter_notifier.dart';
import 'package:appstructure/data/network/apis/ghanshyam_vijay/ghanshyam_vijay_notifier.dart';
import 'package:appstructure/provider/theme_provider.dart';
import 'package:appstructure/ui/pdf/pdf_view.dart';
import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:dialogs/dialogs/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/dimentions.dart';

class GhanShyamVijay extends StatefulWidget {
  const GhanShyamVijay({Key? key, required this.isFromNotification}) : super(key: key);
  final bool isFromNotification;

  @override
  _GhanShyamVijayState createState() => _GhanShyamVijayState();
}

class Year {
  Year({
    required this.id,
    required this.name,
  });
  final int id;
  final String name;
}

class _GhanShyamVijayState extends State<GhanShyamVijay> {
  static List<Year> _years = [];
  String selectedYear = '';
  bool isFilterApply = false;
  final MultiSelectController<String> _multiSelectController = MultiSelectController();
  MessageDialog? messageDialog;

  final ScrollController _controller = ScrollController();
  final ScrollController _filterController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //showDataMigrationDialog();
      fetchData(false);
      getFilterYearList();
    });
    super.initState();
    _controller.addListener(_scrollListener);
    _filterController.addListener(_scrollFilterListener);
  }

  void showDataMigrationDialog() {
    final box = GetStorage();
    if (box.read('Theme') == 'Dark') {
      messageDialog = MessageDialog(
          dialogBackgroundColor: CustomColors.ColorBlack2,
          buttonOkOnPressed: () {
            messageDialog!.dismiss(context);
          },
          buttonOkColor: CustomColors.ColorBlack,
          title: 'Swaminarayan Gadi',
          titleColor: CustomColors.ColorWhite,
          message: 'Data migration is going on. So, you may not get the latest data.',
          messageColor: CustomColors.ColorWhite,
          buttonOkText: 'Got it',
          dialogRadius: 15.r,
          buttonRadius: 15.r);
      messageDialog!.show(context, barrierColor: CustomColors.ColorBlack2);
    } else {
      messageDialog = MessageDialog(
          dialogBackgroundColor: CustomColors.ColorWhite,
          buttonOkOnPressed: () {
            messageDialog!.dismiss(context);
          },
          buttonOkColor: CustomColors.ColorBlack2,
          title: 'Swaminarayan Gadi',
          titleColor: CustomColors.ColorBlack2,
          message: 'Data migration is going on. So, you may not get the latest data.',
          messageColor: CustomColors.ColorBlack2,
          buttonOkText: 'Got it',
          dialogRadius: 15.r,
          buttonRadius: 15.r);
      messageDialog!.show(context, barrierColor: CustomColors.ColorWhite);
    }
  }

  void fetchData(bool isLoadMore) {
    Provider.of<GhanshyamVijayNotifier>(context, listen: false).fetchGhanShyamVijayData(isLoadMore);
  }

  void fetchFilterData(String year, bool isLoadMore) {
    Provider.of<GhanshyamVijayFilterNotifier>(context, listen: false).fetchGhanShyamVijayFilterData(year, isLoadMore);
  }

  // void getFilterYearList() {
  //   final currDt = DateTime.now();
  //   // ignore: prefer_final_locals
  //   List<Year> years = [];
  //   for (int i = 0; i < 24; i++) {
  //     // ignore: prefer_final_locals
  //     String year = '${currDt.year - i}';
  //     if (i == 23) {
  //       years.add(Year(id: i, name: 'All'));
  //     } else {
  //       years.add(Year(id: i, name: year));
  //     }
  //   }
  //   setState(() {
  //     _years = years;
  //   });
  // }

  void getFilterYearList() {
    final currDt = DateTime.now();
    final yearLength = currDt.year - 1955;

    final List<Year> years = [];
    for (int i = 0; i < yearLength; i++) {
      final String year = '${currDt.year - i}';
      log('years: $year');
      years.add(Year(id: i, name: year));
    }

    setState(() {
      _years = years;
    });
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      fetchData(true);
    }
  }

  void _scrollFilterListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      fetchFilterData(selectedYear, true);
    }
  }

  Future<bool> _onBackPressed() async {
    Navigator.of(context).pop(true);
    if (widget.isFromNotification) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomFooterNavigation(),
        ),
      );
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarCustom(
                title: 'ghanshyam_vijay'.tr,
                isBack: true,
                isFilter: true,
                isSearch: false,
                backCallback: () {
                  //Navigator.of(context).pop(true);
                  _onBackPressed();
                },
                filterCallBack: () {
                  _modalBottomSheetMenu(themeProvider);
                  //_showMultiSelect(context);
                },
                searchCallBack: () {},
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 0,
                    top: 0,
                  ),
                  child: isFilterApply
                      ? Consumer<GhanshyamVijayFilterNotifier>(builder: (context, data, _) {
                          if (data.isLoading) {
                            return Container(
                              height: 100.h,
                              child: const Align(
                                alignment: Alignment.topCenter,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return CustomScrollView(
                              controller: _controller,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              slivers: [
                                SliverGrid(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => PDFView(pdfUrl: data.ghanShyamVijayFilterList[index].pdfFile.toString()),
                                              ));
                                        },
                                        child: itemGhanshyamVijay(
                                            data.ghanShyamVijayFilterList[index].publishOn.toString(),
                                            data.ghanShyamVijayFilterList[index].bannerImage.toString(),
                                            data.ghanShyamVijayFilterList[index].pdfFile.toString()),
                                      );
                                    },
                                    childCount: data.ghanShyamVijayFilterList.length,
                                  ),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, childAspectRatio: 0.53, crossAxisSpacing: Dimentions.heightMargin10),
                                ),
                                SliverToBoxAdapter(
                                  child: SizedBox(
                                    height: 50.h,
                                    child: Visibility(
                                      visible: data.isLoadMoreItem,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        })
                      : Consumer<GhanshyamVijayNotifier>(builder: (context, data, _) {
                          if (data.isLoading) {
                            return Container(
                              height: 100.h,
                              child: const Align(
                                alignment: Alignment.topCenter,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return CustomScrollView(
                              controller: _controller,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              slivers: [
                                SliverGrid(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => PDFView(pdfUrl: data.ghanShyamVijayList[index].pdfFile.toString()),
                                              ));
                                        },
                                        child: itemGhanshyamVijay(data.ghanShyamVijayList[index].publishOn.toString(),
                                            data.ghanShyamVijayList[index].bannerImage.toString(), data.ghanShyamVijayList[index].pdfFile.toString()),
                                      );
                                    },
                                    childCount: data.ghanShyamVijayList.length,
                                  ),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, childAspectRatio: 0.53, crossAxisSpacing: Dimentions.heightMargin10),
                                ),
                                SliverToBoxAdapter(
                                  child: SizedBox(
                                    height: 50.h,
                                    child: Visibility(
                                      visible: data.isLoadMoreItem,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _checkMemory() {
    // ignore: prefer_final_locals
    ImageCache _imageCache = PaintingBinding.instance.imageCache;
    if (_imageCache.liveImageCount >= 55 << 20) {
      _imageCache.clear();
      _imageCache.clearLiveImages();
    }
  }

  Widget itemGhanshyamVijay(String title, String image, String pdfUrl) {
    // ignore: prefer_final_locals
    DateTime tempDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(title);
    final inputDate = DateTime.parse(tempDate.toString());
    final outputFormat = DateFormat('MMM yyyy');
    final outputDate = outputFormat.format(inputDate);
    _checkMemory();
    return SizedBox(
      height: 170.h,
      width: 150.w,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            child: Image.network(image,
                errorBuilder: (context, exception, stackTrace) {
                  return Image.asset(
                    'assets/images/banner_dashboard.jpg',
                    height: 170.h,
                    width: 150.w,
                    fit: BoxFit.cover,
                  );
                },
                cacheWidth: 500,
                cacheHeight: 500,
                height: 170.h,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  // ignore: always_put_control_body_on_new_line
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 170.h,
                    width: 150.w,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }),
          ),
          announcementWidget(outputDate, true),
        ],
      ),
    );
  }

  Widget announcementWidget(String text, bool isGV) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimentions.widthMargin05),
      child: FractionalTranslation(
        translation: const Offset(0.0, -0.5),
        child: Align(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: isGV ? BorderRadius.circular(10.r) : BorderRadius.circular(15.r),
                  color: Theme.of(context).colorScheme.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.ColorBlack2.withOpacity(.04),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, Dimentions.widthMargin05),
                    )
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                  left: Dimentions.widthMargin05,
                  right: Dimentions.widthMargin05,
                  top: Dimentions.widthMargin05,
                  bottom: Dimentions.widthMargin05,
                ),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            alignment: isGV ? Alignment.topCenter : Alignment.topLeft),
      ),
    );
  }

  void _modalBottomSheetMenu(ThemeProvider themeProvider) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (builder) {
          return Wrap(
            children: [
              Container(
                color: Colors.transparent,
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).bottomSheetTheme.backgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Container(
                                    margin: const EdgeInsets.all(10),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: themeProvider.isDarkMode ? const Color(0xFF262829) : const Color(0xFFFFFFFF),
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.08),
                                            blurRadius: 5.0,
                                          ),
                                        ]),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: 25,
                                        color: themeProvider.isDarkMode ? const Color(0xFFDADADA) : const Color(0xFF373A40),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                child: Text(
                                  'filter'.tr,
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedYear = '';
                                  });
                                  _multiSelectController.deselectAll();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                                  child: Text(
                                    'reset'.tr,
                                    style: Theme.of(context).textTheme.displayMedium!.apply(color: CustomColors.OrangeColor),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'year'.tr,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: MultiSelectContainer(
                                controller: _multiSelectController,
                                maxSelectableCount: 1,
                                singleSelectedItem: true,
                                textStyles: MultiSelectTextStyles(
                                  selectedTextStyle: Theme.of(context).textTheme.headlineSmall!.apply(color: CustomColors.ColorWhite),
                                  textStyle: Theme.of(context).textTheme.headlineSmall!.apply(color: CustomColors.OrangeColor),
                                ),
                                prefix: MultiSelectPrefix(
                                  selectedPrefix: const Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                                items: List.generate(_years.length, (index) {
                                  return MultiSelectCard(
                                    value: _years[index].name,
                                    label: _years[index].name,
                                    // ignore: avoid_bool_literals_in_conditional_expressions
                                    selected: _years[index].name == selectedYear ? true : false,
                                    decorations: MultiSelectItemDecorations(
                                      decoration:
                                          BoxDecoration(border: Border.all(color: CustomColors.OrangeColor), borderRadius: BorderRadius.circular(20)),
                                      selectedDecoration: BoxDecoration(color: CustomColors.OrangeColor, borderRadius: BorderRadius.circular(20)),
                                    ),
                                  );
                                }),
                                onChange: (allSelectedItems, selectedItem) {
                                  setState(() {
                                    selectedYear = '$selectedItem';
                                  });
                                }),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (selectedYear == '') {
                                  setState(() {
                                    isFilterApply = false;
                                  });
                                  Navigator.pop(context);
                                  fetchData(false);
                                } else {
                                  setState(() {
                                    isFilterApply = true;
                                  });
                                  Navigator.pop(context);
                                  fetchFilterData(selectedYear, false);
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: SizedBox(
                                  width: 250.w,
                                  height: 25.h,
                                  child: Text(
                                    'apply'.tr,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.displayMedium!.apply(
                                          color: CustomColors.ColorWhite,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          );
        });
  }
}
