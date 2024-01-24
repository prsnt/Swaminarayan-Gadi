import 'package:appstructure/data/network/apis/about_us/about_us_notifier.dart';
import 'package:appstructure/models/about_us_model.dart';
import 'package:appstructure/ui/about_us/about_us_webview.dart';
import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;
import 'package:provider/provider.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    super.initState();
  }

  Future<AboutUsModel?> getAboutUsData() async {
    final data = Provider.of<AboutUsNotifier>(context, listen: false);
    await data.fetchAboutUsData();
    return data.aboutUsModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarCustom(
                title: 'about_us'.tr,
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
                  child: FutureBuilder<AboutUsModel?>(
                    future: getAboutUsData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: Dimentions.widthMargin20, right: Dimentions.widthMargin20),
                              child: Text(
                                '${snapshot.data!.data![1].title}',
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              margin: EdgeInsets.only(left: Dimentions.widthMargin20, right: Dimentions.widthMargin20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: CachedNetworkImage(
                                    height: 200.h, fit: BoxFit.cover, imageUrl: snapshot.data!.data![0].imageJson![0].imageurl.toString()),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: Dimentions.widthMargin10, right: Dimentions.widthMargin10),
                              child: Html(
                                data: '${snapshot.data!.data![1].desc}',
                                // onLinkTap: (url, _, __, ___) {
                                //   _launchWebsiteUrl(url);
                                // },
                                onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, ___) {
                                  //open URL in webview, or launch URL in browser, or any other logic here
                                },
                                style: {
                                  'p': Style(
                                      //margin: EdgeInsets.zero,
                                      fontSize: FontSize.large,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'outfit')
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: Dimentions.widthMargin10, right: Dimentions.widthMargin10),
                              child: Html(
                                data: '${snapshot.data!.data![2].desc}',
                                // onLinkTap: (url, _, __, ___) {
                                //   _launchWebsiteUrl(url);
                                // },
                                onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, dom.Element? element) {
                                  //open URL in webview, or launch URL in browser, or any other logic here
                                  navigateAboutUsWebView(element!.text, url!);
                                },
                                style: {
                                  'p': Style(
                                      //margin: EdgeInsets.zero,
                                      fontSize: FontSize.large,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'outfit'),
                                  'a': Style(color: CustomColors.OrangeColor)
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
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

  // Future<void> _launchWebsiteUrl(String? url) async {
  //   Uri? uri = Uri.parse(url!);
  //   if (!await launchUrl(uri)) {
  //     throw 'Could not launch $uri';
  //   }
  // }

  void navigateAboutUsWebView(String title, String url) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AboutUsWebView(title: title, url: url),
        ));
  }
}
