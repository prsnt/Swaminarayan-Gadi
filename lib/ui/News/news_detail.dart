import 'dart:developer';

import 'package:appstructure/data/network/apis/news_list/news_detail_image_gallary_notifier.dart';
import 'package:appstructure/data/network/apis/news_list/news_detail_notifier.dart';
import 'package:appstructure/data/network/apis/news_list/news_detail_video_notifier.dart';
import 'package:appstructure/models/news_detail_videos_model.dart';
import 'package:appstructure/models/news_image_gallary_model.dart';
import 'package:appstructure/ui/News/media_gallary_news.dart';
import 'package:appstructure/ui/News/news_detail_gallary.dart';
import 'package:appstructure/ui/News/news_detail_video.dart';
import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/theme_provider.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({Key? key, this.title, this.date, this.image, this.id}) : super(key: key);
  final String? id;
  final String? title;
  final String? date;
  final String? image;

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  void initState() {
    log('Image: ${widget.image}');
    log('Date: ${widget.date}');

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData(widget.id.toString());
    });
    super.initState();
  }

  void fetchData(String id) {
    Provider.of<NewsDetailNotifier>(context, listen: false).fetchNewsDetailData(id);
  }

  Future<List<NewsGallaryImageJson>?> getNewsDetailImageGallaryData(String imageGallaryIds) async {
    final data = Provider.of<NewsDetailImageGallaryNotifier>(context, listen: false);
    await data.fetchNewsDetailImageGallaryData(imageGallaryIds);
    return data.newsGallaryImageJsonList;
  }

  Future<List<NewsDetailVideosData>?> getNewsDetailVideosData(String videoIds) async {
    final data = Provider.of<NewsDetailVideoNotifier>(context, listen: false);
    await data.fetchNewsDetailVideoData(videoIds);
    return data.newsDetailVideosDataList;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final DateTime tempDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(widget.date.toString());
    final inputDate = DateTime.parse(tempDate.toString());
    final outputDayFormat = DateFormat('EEEE dd MMM yyyy');
    final date = outputDayFormat.format(inputDate);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBarCustom(
              title: 'news_details'.tr,
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
                child: Consumer<NewsDetailNotifier>(
                  builder: (context, newsDetail, _) {
                    if (!newsDetail.loading) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: Dimentions.heightMargin20, right: Dimentions.heightMargin20),
                            child: Text('${widget.title}', style: Theme.of(context).textTheme.displaySmall!.apply(fontSizeDelta: 2.0)),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: Dimentions.heightMargin20, right: Dimentions.heightMargin20),
                                    child: Text('Swaminaryan Mandir', style: Theme.of(context).textTheme.bodyLarge!.apply(color: Colors.grey)),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: Dimentions.heightMargin20, right: Dimentions.heightMargin20),
                                    child: Text(date, style: Theme.of(context).textTheme.bodyLarge!.apply(color: Colors.grey)),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: GestureDetector(
                                  onTap: () {
                                    shareNewsData(widget.title.toString(), newsDetail.content.toString(), date);
                                  },
                                  child: Image.asset(
                                    'assets/images/share.png',
                                    color: CustomColors.OrangeColor,
                                    height: Dimentions.widthMargin20,
                                    width: Dimentions.widthMargin20,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Stack(
                            children: <Widget>[
                              Positioned(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.image.toString(),
                                    imageBuilder: (context, imageProvider) => Container(
                                      height: 200.h,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                      height: 200.h,
                                      width: MediaQuery.of(context).size.width,
                                      child: const Center(child: CircularProgressIndicator()),
                                    ),
                                    errorWidget: (context, url, error) => Image.asset(
                                      'assets/images/banner_dashboard.jpg',
                                      height: 200.h,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Flex(
                                direction: Axis.vertical,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 180.h),
                                    child: Card(
                                      margin: EdgeInsets.zero,
                                      color: themeProvider.isDarkMode ? const Color(0xFF1C1F26) : const Color(0xFFFFFFFF),
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
                                            child: Html(
                                              data: newsDetail.content,
                                              onLinkTap: (url, _, __, ___) {
                                                _launchWebsiteUrl(url);
                                              },
                                              style: {
                                                '#': Style(
                                                    textAlign: TextAlign.justify,
                                                    //margin: EdgeInsets.zero,
                                                    fontSize: FontSize.medium,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'outfit'),
                                                'a': Style(color: CustomColors.OrangeColor)
                                              },
                                            ),
                                          ),
                                          newsVideoList(newsDetail.video.toString()),
                                          mediaGallaryRow(newsDetail.imageGallary.toString()),
                                          Container(
                                            height: 120.h,
                                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                            width: double.infinity,
                                            child: newsGallaryList(
                                              newsDetail.imageGallary.toString(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      );
                    } else {
                      return Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget newsVideoList(String newsVideoIds) {
    return Container(
      child: newsVideoIds != ''
          ? FutureBuilder<List<NewsDetailVideosData>?>(
              future: getNewsDetailVideosData(newsVideoIds),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return newsVideoItem(snapshot.data);
                } else {
                  return const SizedBox();
                }
              })
          : const SizedBox(),
    );
  }

  Widget newsVideoItem(List<NewsDetailVideosData>? newsDetailVideoList) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
      child: CarouselSlider.builder(
        options: CarouselOptions(
            autoPlay: false,
            height: 170.h,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            viewportFraction: 1,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {}),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return cardViewVideo(
            '${newsDetailVideoList[index].title}',
            '${newsDetailVideoList[index].videoUrl}',
          );
        },
        itemCount: newsDetailVideoList!.length,
      ),
    );
  }

  Widget mediaGallaryRow(String imageGallaryId) {
    return Visibility(
      // ignore: avoid_bool_literals_in_conditional_expressions
      visible: imageGallaryId.isNotEmpty ? true : false,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'media_gallery'.tr,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailGallary(
                        imageGallaryIds: imageGallaryId,
                      ),
                    ));
              },
              child: Row(
                children: [
                  Text(
                    'view_all'.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Icon(
                    size: 15,
                    Icons.chevron_right,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget newsGallaryList(String imageGallaryId) {
    if (imageGallaryId == '') {
      return Container(
        child: null,
      );
    } else {
      return FutureBuilder<List<NewsGallaryImageJson>?>(
          future: getNewsDetailImageGallaryData(imageGallaryId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, int index) {
                  return newsGallaryItem(
                    snapshot.data![index].imageurl.toString(),
                    snapshot.data,
                    index,
                  );
                },
              );
            } else {
              return Container(
                height: 120.h,
                child: const Center(child: CircularProgressIndicator()),
              );
            }
          });
    }
  }

  Widget newsGallaryItem(String image, List<NewsGallaryImageJson>? list, int index) {
    return InkWell(
      onTap: () {
        // ignore: prefer_final_locals
        List<String> imageList = [];
        for (int i = 0; i < list!.length; i++) {
          imageList.add(list[i].imageurl.toString());
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MediaGallaryNews(
              galleryItems: imageList,
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              initialIndex: index,
              scrollDirection: Axis.horizontal,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              height: 120.h,
              width: 140.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              height: 190.h,
              width: 150.w,
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Image.asset(
              'assets/images/banner_dashboard.jpg',
              height: 120.h,
              width: 140.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  String? getYoutubeThumbnail(String videoUrl) {
    final Uri uri = Uri.parse(videoUrl);
    // ignore: unnecessary_null_comparison
    if (uri == null) {
      return null;
    }
    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }

  Widget cardViewVideo(String title, String image) {
    // ignore: prefer_final_locals
    String? thumbNail = getYoutubeThumbnail('https://www.youtube.com/watch?v=$image');
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailVideo(
                youtubeId: image,
              ),
            ));
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
              child: CachedNetworkImage(
                imageUrl: thumbNail.toString(),
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
              child: Image.asset(
                'assets/images/dashboard_card_hover.png',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: Dimentions.widthMargin15, vertical: Dimentions.heightMargin15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 300.w,
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.ColorWhite,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/play_icon.png',
                      width: Dimentions.widthMargin20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> shareNewsData(String title, String desc, String date) async {
    // ignore: prefer_final_locals
    String description = parseHtmlString(desc);
    // ignore: prefer_final_locals
    String? data = '$title \n\n $date \n\n $description';
    await FlutterShare.share(title: 'Share Here', text: data);
  }

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  Future<void> _launchWebsiteUrl(String? url) async {
    // ignore: prefer_final_locals
    Uri? uri = Uri.parse(url!);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }
}
