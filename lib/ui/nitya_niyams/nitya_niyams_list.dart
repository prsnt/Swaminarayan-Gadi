import 'package:appstructure/data/network/apis/nitya_niyam/nitya_niyam_category_notifier.dart';
import 'package:appstructure/data/network/apis/nitya_niyam/nitya_niyam_notifier.dart';
import 'package:appstructure/models/nitya_niyam_category_model.dart';
import 'package:appstructure/models/nitya_niyam_model.dart';
import 'package:appstructure/provider/theme_provider.dart';
import 'package:appstructure/ui/nitya_niyams/nitya_niyam_detail.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:appstructure/utils/string_casing_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NityaNiyamList extends StatefulWidget {
  const NityaNiyamList({Key? key}) : super(key: key);

  @override
  _NityaNiyamListState createState() => _NityaNiyamListState();
}

class _NityaNiyamListState extends State<NityaNiyamList> {
  String languageId = '1';

  @override
  void initState() {
    super.initState();
  }

  Future<NityaNiyamCategoryModel?> fetchNityaNiyamCategoryData() async {
    final data = Provider.of<NityaNiyamCategoryNotifier>(context, listen: false);
    await data.fetchNityaNiyamCategoryData();
    return data.nityaNiyamCategoryModel;
  }

  Future<NityaNiyamModel?> fetchNityaNiyamData(String id) async {
    final data = Provider.of<NityaNiyamNotifier>(context, listen: false);
    await data.fetchNityaNiyamData(id);
    return data.nityaNiyamModel;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: Dimentions.widthMargin10,
            right: Dimentions.widthMargin10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: Dimentions.widthMargin10),
                        child: Text(
                          'niyams'.tr,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: themeProvider.isDarkMode ? const Color(0xFF262829) : const Color(0xFFFFFFFF),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.08),
                                blurRadius: 5.0,
                              ),
                            ]),
                        child: PopupMenuButton(
                          child: Icon(
                            Icons.translate,
                            size: 25,
                            color: themeProvider.isDarkMode ? const Color(0xFFDADADA) : const Color(0xFF373A40),
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'select_language'.tr,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  languageId = '1';
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('english'.tr, style: Theme.of(context).textTheme.bodyLarge),
                                  Radio(
                                    activeColor: CustomColors.OrangeColor,
                                    groupValue: languageId,
                                    onChanged: (value) {},
                                    value: '1',
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  languageId = '2';
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('gujarati'.tr, style: Theme.of(context).textTheme.bodyLarge),
                                  Radio(
                                    activeColor: CustomColors.OrangeColor,
                                    groupValue: languageId,
                                    value: '2',
                                    onChanged: (String? value) {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Container(
                    child: FutureBuilder<NityaNiyamCategoryModel?>(
                      future: fetchNityaNiyamCategoryData(),
                      builder: (context, nityaNityamCategorySnapshot) {
                        if (nityaNityamCategorySnapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: nityaNityamCategorySnapshot.data!.data!.length,
                            itemBuilder: (context, int index) {
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          nityaNityamCategorySnapshot.data!.data![index].name!.capitalizeFirstofEach(),
                                          style: Theme.of(context).textTheme.displayMedium,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          gotoNityaNiyamDetailScreen(nityaNityamCategorySnapshot.data!.data![index].id.toString(), '', index, true);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(top: 12),
                                          child: Image.asset(
                                            'assets/images/play_all.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Card(
                                    color: Colors.transparent,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        gradient: LinearGradient(
                                          colors: [
                                            if (themeProvider.isDarkMode) const Color(0xFFFFFFFF).withOpacity(0.10) else const Color(0xFFFFFFFF),
                                            if (themeProvider.isDarkMode) const Color(0xFFFFFFFF).withOpacity(0.02) else const Color(0xFFFFFFFF)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      child: FutureBuilder<NityaNiyamModel?>(
                                        future: fetchNityaNiyamData('${nityaNityamCategorySnapshot.data!.data![index].id}'),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.done) {
                                            return ListView.separated(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                physics: const NeverScrollableScrollPhysics(),
                                                separatorBuilder: (_, __) => Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                                      child: Divider(
                                                          thickness: 1.5,
                                                          color: themeProvider.isDarkMode
                                                              ? const Color(0xFFFFFFFF).withOpacity(0.08)
                                                              : const Color(0xFFF1F1F1)),
                                                    ),
                                                itemCount: snapshot.data!.data!.length,
                                                itemBuilder: (context, int index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      gotoNityaNiyamDetailScreen(snapshot.data!.data![index].category.toString(),
                                                          snapshot.data!.data![index].id.toString(), index, false);
                                                    },
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      padding: const EdgeInsets.only(top: 10, right: 10, left: 20),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                              themeProvider.isDarkMode
                                                                  ? 'assets/images/play_icon_dark.png'
                                                                  : 'assets/images/audio_play.png',
                                                              height: 60.h,
                                                              width: 60.w),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Flexible(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  languageId == '1'
                                                                      ? '${snapshot.data!.data![index].englishNityaNiyam!.title}'
                                                                      : '${snapshot.data!.data![index].gujaratiNityaNiyam!.title}',
                                                                  style: TextStyle(
                                                                      color: themeProvider.isDarkMode
                                                                          ? const Color(0xFFFFFFFF).withOpacity(0.40)
                                                                          : const Color(0xFF000000),
                                                                      fontSize: 16.sp,
                                                                      fontWeight: FontWeight.w500,
                                                                      fontFamily: 'outfit'),
                                                                ),
                                                                SizedBox(
                                                                  width: 10.w,
                                                                ),
                                                                Html(
                                                                  data: languageId == '1'
                                                                      ? '${snapshot.data!.data![index].englishNityaNiyam!.desc}'
                                                                      : '${snapshot.data!.data![index].englishNityaNiyam!.desc}',
                                                                  style: {
                                                                    '#': Style(
                                                                        //margin: EdgeInsets.zero,

                                                                        maxLines: 1,
                                                                        textOverflow: TextOverflow.ellipsis,
                                                                        fontSize: FontSize.small,
                                                                        color: themeProvider.isDarkMode
                                                                            ? const Color(0xFFFFFFFF).withOpacity(0.40)
                                                                            : const Color(0xFF000000).withOpacity(0.40),
                                                                        fontFamily: 'outfit'),
                                                                    'a': Style(color: CustomColors.OrangeColor)
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                  // return Text('Test');
                                                });
                                          } else {
                                            return Container(
                                              height: 100.h,
                                              child: const Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void gotoNityaNiyamDetailScreen(String category, String id, int selectedIndex, bool isPlayAll) {
    if (isPlayAll) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NityaNiyamDetail(
            category: category,
            selectedIndex: 0,
            id: id,
            isPlayAll: isPlayAll,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NityaNiyamDetail(
            category: category,
            selectedIndex: selectedIndex,
            id: id,
            isPlayAll: isPlayAll,
          ),
        ),
      );
    }
  }
}
