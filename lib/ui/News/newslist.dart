import 'package:appstructure/Interface/Interface.dart';
import 'package:appstructure/data/network/apis/news_list/news_list_category_notifier.dart';
import 'package:appstructure/data/network/apis/news_list/news_list_notifier.dart';
import 'package:appstructure/models/news_list_category_model.dart';
import 'package:appstructure/models/news_list_model.dart';
import 'package:appstructure/ui/News/news_detail.dart';
import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:appstructure/utils/app_constant.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dialogs/dialogs/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../provider/theme_provider.dart';

class NewsListing extends StatefulWidget {
  const NewsListing({Key? key}) : super(key: key);

  @override
  State<NewsListing> createState() => _NewsListingState();
}

class Year {
  Year({
    required this.id,
    required this.name,
  });
  final int id;
  final String name;
}

class _NewsListingState extends State<NewsListing> {
  final ScrollController _controller = ScrollController();
  final _searchController = TextEditingController();
  Interface interface = Interface();
  bool _isSearchInputVisible = false;
  String? newsCategoryId = '', newsSelectedYear = '', search = '';
  TextEditingController searchController = TextEditingController();
  final MultiSelectController<String> _multiSelectNewsCategoryController = MultiSelectController();
  final MultiSelectController<String> _multiSelectNewsYearController = MultiSelectController();
  static List<Year> _years = [];
  bool isFilterApply = false;
  MessageDialog? messageDialog;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
      Provider.of<NewsListCategoryNotifier>(context, listen: false).fetchNewsListCategoryData();
      getFilterYearList();
    });
    _controller.addListener(_scrollListener);
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

  void fetchData() {
    Provider.of<NewsListNotifier>(context, listen: false).fetchNewsData(newsCategoryId!, newsSelectedYear!, search!);
  }

  void fetchNewsFilterData(bool isFilterApply) {
    Provider.of<NewsListNotifier>(context, listen: false).fetchNewsFilterData(newsCategoryId!, newsSelectedYear!, isFilterApply, search!);
  }

  void fetchNewsSearchData() {
    Provider.of<NewsListNotifier>(context, listen: false).fetchNewsSearchData(newsCategoryId!, newsSelectedYear!, search!);
  }

  void getFilterYearList() {
    final currDt = DateTime.now();
    // ignore: prefer_final_locals
    List<Year> years = [];
    for (int i = 0; i < 25; i++) {
      // ignore: prefer_final_locals
      String year = '${currDt.year - i}';
      // if (i == 23) {
      //   years.add(Year(id: i, name: 'All'));
      // } else {
      //   years.add(Year(id: i, name: year));
      // }
      years.add(Year(id: i, name: year));
    }
    setState(() {
      _years = years;
    });
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final newsListCategoryData = Provider.of<NewsListCategoryNotifier>(context);
    return VisibilityDetector(
      onVisibilityChanged: (visibilityInfo) {
        // final visiblePercentage = visibilityInfo.visibleFraction * 100;
        // if (visiblePercentage > 1) {
        //   if (!AppConstants.isMirgrationDialogShow) {
        //     AppConstants.isMirgrationDialogShow = true;
        //     showDataMigrationDialog();
        //   }
        // }
      },
      key: const Key('new_list'),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarCustom(
                title: 'news'.tr,
                isBack: false,
                isFilter: true,
                isSearch: true,
                backCallback: () {},
                filterCallBack: () {
                  _modalBottomSheetMenu(themeProvider, newsListCategoryData.newsListCategoryModel!.data!.newsCategoryDataList);
                },
                searchCallBack: () {
                  setState(() {
                    _isSearchInputVisible = true;
                  });
                },
              ),
              //searchBox(),
              Visibility(
                visible: _isSearchInputVisible,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (searchText) {
                      setState(() {
                        search = searchText;
                      });
                      fetchNewsSearchData();
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(4),
                        border: OutlineInputBorder(
                          borderSide: themeProvider.isDarkMode ? BorderSide.none : BorderSide(color: const Color(0xFF13161D).withOpacity(0.30)),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        filled: true,
                        fillColor: themeProvider.isDarkMode ? const Color(0xFF262829) : const Color(0xFFFFFFFF),
                        prefixIcon: Icon(Icons.search,
                            color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.20) : const Color(0xFF13161D).withOpacity(0.30)),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            searchController.clear();
                            setState(() {
                              _isSearchInputVisible = false;
                              search = '';
                            });
                            fetchNewsSearchData();
                          },
                          child: Icon(Icons.clear,
                              color:
                                  themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.20) : const Color(0xFF13161D).withOpacity(0.30)),
                        ),
                        hintText: 'search_here'.tr,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.20) : const Color(0xFF13161D).withOpacity(0.30),
                        )),
                    //onChanged: onSearchTextChanged,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimentions.widthMargin15, right: Dimentions.widthMargin15),
                child: Text('Latest news of Maninagar Shree Swaminarayan Gadi',
                    style: Theme.of(context).textTheme.displayMedium!.apply(fontSizeDelta: 1.4)),
              ),

              Container(
                margin: EdgeInsets.only(
                    left: Dimentions.widthMargin15,
                    top: Dimentions.heightMargin10,
                    bottom: Dimentions.heightMargin10,
                    right: Dimentions.widthMargin20),
                child: Text(
                  'latest_news'.tr,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              Consumer<NewsListNotifier>(builder: (context, data, _) {
                if (data.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (data.newsList.isNotEmpty) {
                    return Expanded(
                      child: _verticalList(data.newsList),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'no_data_found'.tr,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    );
                  }
                }
              })
            ],
          ),
        )),
      ),
    );
  }

  ListView _verticalList(List<NewsData> newsList) {
    return ListView.separated(
      controller: _controller,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: newsList.length,
      separatorBuilder: (_, __) => Container(),
      itemBuilder: (context, int index) {
        return itemNews(newsList[index]);
      },
    );
  }

  Widget itemNews(NewsData newsData) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final DateTime tempDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(newsData.publishOn.toString());
    final inputDate = DateTime.parse(tempDate.toString());
    final outputDayFormat = DateFormat('dd');
    final day = outputDayFormat.format(inputDate);
    final outputMonthFormat = DateFormat('MMM');
    final month = outputMonthFormat.format(inputDate);
    final outputYearFormat = DateFormat('yyyy');
    final year = outputYearFormat.format(inputDate);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetail(
                title: newsData.title,
                date: newsData.createdDate,
                image: newsData.image,
                id: newsData.id,
              ),
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
            left: Dimentions.widthMargin15, right: Dimentions.widthMargin15, bottom: Dimentions.heightMargin10, top: Dimentions.widthMargin10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              gradient: LinearGradient(
                colors: [
                  if (themeProvider.isDarkMode) const Color(0xFF373A40) else const Color(0xFFFFFFFF),
                  if (themeProvider.isDarkMode) const Color(0xFF13161D) else const Color(0xFFFFFFFF),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
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
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    child: newsData.image == ''
                        ? Image.asset(
                            'assets/images/banner_dashboard.jpg',
                            height: 170.h,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: '${newsData.image}',
                            imageBuilder: (context, imageProvider) => Container(
                              height: 170.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              height: 170.h,
                              width: MediaQuery.of(context).size.width,
                              child: const Center(child: CircularProgressIndicator()),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/banner_dashboard.jpg',
                              height: 170.h,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
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
                              day,
                              style: TextStyle(fontSize: 18.sp, color: CustomColors.ColorWhite, fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: Dimentions.heightMargin05),
                              child: Text(
                                month,
                                style: TextStyle(fontSize: 10.sp, color: CustomColors.ColorWhite, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              year,
                              style: TextStyle(fontSize: 10.sp, color: CustomColors.ColorWhite, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: Dimentions.heightMargin10, left: Dimentions.widthMargin15, right: Dimentions.widthMargin15),
                child: Text(
                  '${newsData.title}',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .apply(color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.90) : const Color(0xFF13161D)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Dimentions.heightMargin10, left: Dimentions.widthMargin15, right: Dimentions.widthMargin15),
                child: Text(
                  '${newsData.metaDescription}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .apply(color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.90) : const Color(0xFF373A40)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: Dimentions.heightMargin10,
                    left: Dimentions.widthMargin15,
                    bottom: Dimentions.heightMargin20,
                    right: Dimentions.widthMargin15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Shree Swaminarayan Mandir',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .apply(color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.50) : const Color(0xFF5B5D62)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        shareNewsData(newsData);
                      },
                      child: Image.asset(
                        'assets/images/share.png',
                        color: CustomColors.OrangeColor,
                        height: 20.h,
                        width: 20.w,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleViewAll(String title) {
    return Container(
      margin: EdgeInsets.only(left: Dimentions.widthMargin15, top: Dimentions.heightMargin20, right: Dimentions.widthMargin15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Row(
            children: [
              Text(
                'view_all'.tr,
                style: Theme.of(context).textTheme.headlineSmall,
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

  Future<void> shareNewsData(NewsData newsData) async {
    // ignore: prefer_final_locals
    String? title = newsData.title;
    // ignore: prefer_final_locals
    String? desc = newsData.desc;
    // ignore: prefer_final_locals
    String? data = '$title \n\n $desc';
    await FlutterShare.share(title: 'Share Here', text: data);
  }

  void _modalBottomSheetMenu(ThemeProvider themeProvider, List<NewsCategoryData>? newsCategoryDataList) {
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
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).bottomSheetTheme.backgroundColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Text(
                            'filter'.tr,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _multiSelectNewsCategoryController.deselectAll();
                            _multiSelectNewsYearController.deselectAll();
                            setState(() {
                              newsCategoryId = '';
                              newsSelectedYear = '';
                              isFilterApply = false;
                            });
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
                        'category'.tr,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MultiSelectContainer(
                          controller: _multiSelectNewsCategoryController,
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
                          items: List.generate(newsCategoryDataList!.length, (index) {
                            return MultiSelectCard(
                              value: newsCategoryDataList[index].id.toString(),
                              label: newsCategoryDataList[index].name.toString(),
                              // ignore: avoid_bool_literals_in_conditional_expressions
                              selected: newsCategoryId == newsCategoryDataList[index].id.toString() ? true : false,
                              decorations: MultiSelectItemDecorations(
                                decoration:
                                    BoxDecoration(border: Border.all(color: CustomColors.OrangeColor), borderRadius: BorderRadius.circular(20)),
                                selectedDecoration: BoxDecoration(color: CustomColors.OrangeColor, borderRadius: BorderRadius.circular(20)),
                              ),
                            );
                          }),
                          onChange: (allSelectedItems, selectedItem) {
                            setState(() {
                              newsCategoryId = selectedItem.toString();
                            });
                          }),
                    ),
                    SizedBox(
                      height: 20.h,
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
                          controller: _multiSelectNewsYearController,
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
                              selected: _years[index].name == newsSelectedYear ? true : false,
                              decorations: MultiSelectItemDecorations(
                                decoration:
                                    BoxDecoration(border: Border.all(color: CustomColors.OrangeColor), borderRadius: BorderRadius.circular(20)),
                                selectedDecoration: BoxDecoration(color: CustomColors.OrangeColor, borderRadius: BorderRadius.circular(20)),
                              ),
                            );
                          }),
                          onChange: (allSelectedItems, selectedItem) {
                            setState(() {
                              newsSelectedYear = '$selectedItem';
                            });
                          }),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isFilterApply = true;
                          });
                          Navigator.pop(context);
                          fetchNewsFilterData(isFilterApply);
                        },
                        child: Container(
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: SizedBox(
                            width: 250.w,
                            height: 25.h,
                            child: Text('apply'.tr,
                                textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayMedium!.apply(color: CustomColors.ColorWhite)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
              hintText: 'search_here'.tr,
            ),
            autofocus: true,
            controller: _searchController,
          ),
        ],
      ),
    );
  }
}
