import 'package:appstructure/data/network/apis/news_list/news_detail_image_gallary_notifier.dart';
import 'package:appstructure/ui/News/media_gallary_news.dart';
import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NewsDetailGallary extends StatefulWidget {
  const NewsDetailGallary({Key? key, this.imageGallaryIds}) : super(key: key);

  final String? imageGallaryIds;

  @override
  _NewsDetailGallaryState createState() => _NewsDetailGallaryState();
}

class _NewsDetailGallaryState extends State<NewsDetailGallary> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
    super.initState();
  }

  void fetchData() {
    Provider.of<NewsDetailImageGallaryNotifier>(context, listen: false).fetchNewsDetailImageGallaryData(widget.imageGallaryIds.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            AppBarCustom(
              title: 'media_gallery'.tr,
              isBack: true,
              isFilter: false,
              isSearch: false,
              backCallback: () {
                Navigator.of(context).pop(true);
              },
              filterCallBack: () {},
              searchCallBack: () {},
            ),
            Consumer<NewsDetailImageGallaryNotifier>(
              builder: (context, data, _) {
                if (data.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: NotificationListener<ScrollNotification>(
                          onNotification: (scrollNotification) {
                            if (scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent) {
                              data.loadMoreGallaryImage();
                            }
                            return true;
                          },
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: data.size,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // ignore: prefer_final_locals
                                  List<String> imageList = [];
                                  for (int i = 0; i < data.newsGallaryImageJsonList!.length; i++) {
                                    imageList.add(data.newsGallaryImageJsonList![i].imageurl.toString());
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
                                child: itemNewsDetailGallary(
                                  data.newsGallaryImageJsonList![index].imageurl.toString(),
                                ),
                              );
                            },
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.95,
                              mainAxisSpacing: Dimentions.heightMargin10,
                              crossAxisSpacing: Dimentions.heightMargin10,
                            ),
                          )),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget itemNewsDetailGallary(String image) {
    return SizedBox(
      height: 120.h,
      width: 140.w,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        child: Image.network(
          image,
          fit: BoxFit.cover,
          cacheHeight: 500,
          cacheWidth: 500,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/banner_dashboard.jpg',
              height: 120.h,
              width: 140.w,
              fit: BoxFit.cover,
            );
          },
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            // ignore: always_put_control_body_on_new_line
            if (loadingProgress == null) return child;
            return Container(
              height: 100.h,
              width: double.maxFinite,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ImageFullScreen extends StatelessWidget {
  const ImageFullScreen({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBarCustom(
              title: 'media_gallery'.tr,
              isBack: true,
              isFilter: false,
              isSearch: false,
              backCallback: () {
                Navigator.of(context).pop(true);
              },
              filterCallBack: () {},
              searchCallBack: () {},
            ),
            CachedNetworkImage(
              imageUrl: image,
            ),
          ],
        ),
      ),
    );
  }
}
