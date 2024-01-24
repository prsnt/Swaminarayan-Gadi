// ignore_for_file: deprecated_member_use

import 'package:appstructure/data/network/apis/locations/location_filter_notifier.dart';
import 'package:appstructure/data/network/apis/locations/location_notifier.dart';
import 'package:appstructure/data/network/apis/locations/region_filter_notifier.dart';
import 'package:appstructure/models/location_data_model.dart';
import 'package:appstructure/models/location_filter_model.dart';
import 'package:appstructure/models/region_filter_model.dart';
import 'package:appstructure/provider/theme_provider.dart';
import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Locations extends StatefulWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  _LocationsState createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  final ScrollController _controller = ScrollController();
  bool _isSearchInputVisible = false;
  List<LocationDataModel> locationModelList = [];
  List<LocationDataModel> searchLocationModelList = [];
  List<String> filterItemList = [];
  TextEditingController searchController = TextEditingController();
  String? regionId = '';
  bool isFilterApply = false;

  final MultiSelectController<String> _multiSelectController = MultiSelectController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData(true, false);
      Provider.of<RegionFilterNotifier>(context, listen: false).fetchRegionFilterData();
    });
    super.initState();
    _controller.addListener(_scrollListener);
  }

  // ignore: always_declare_return_types
  fetchData(bool isFilter, bool isLoadMore) {
    Provider.of<LocationNotifier>(context, listen: false).fetchLocationData(isFilter, isLoadMore);
  }

  // ignore: always_declare_return_types
  fetchLocationFilterData() {
    Provider.of<LocationFilterNotifier>(context, listen: false).fetchLocationFilterData(regionId!);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      fetchData(false, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final regionFilterData = Provider.of<RegionFilterNotifier>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarCustom(
                title: 'locations'.tr,
                isBack: false,
                isFilter: true,
                isSearch: true,
                backCallback: () {
                  Navigator.of(context).pop(true);
                },
                filterCallBack: () {
                  modalBottomSheetMenu(themeProvider, regionFilterData.regionFilterModel);
                },
                searchCallBack: () {
                  setState(() {
                    _isSearchInputVisible = true;
                  });
                },
              ),
              Visibility(
                visible: _isSearchInputVisible,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: searchController,
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
                            });
                            if (isFilterApply) {
                              fetchLocationFilterData();
                            } else {
                              fetchData(true, false);
                            }
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
                    onChanged: (search) {
                      if (isFilterApply) {
                        Provider.of<LocationFilterNotifier>(context, listen: false).search(search);
                      } else {
                        Provider.of<LocationNotifier>(context, listen: false).search(search);
                      }
                    },
                  ),
                ),
              ),
              Container(
                  child: isFilterApply
                      ? Consumer<LocationFilterNotifier?>(builder: (context, data, _) {
                          if (data!.loading) {
                            return const Center(child: CircularProgressIndicator());
                          } else {
                            if (data.locationFilterList.isNotEmpty) {
                              return Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: Dimentions.widthMargin15, right: Dimentions.widthMargin15),
                                  child: CustomScrollView(
                                    controller: _controller,
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    slivers: [
                                      SliverGrid(
                                        delegate: SliverChildBuilderDelegate((context, index) {
                                          return locationFilterCell(themeProvider, index, data.locationFilterList);
                                        }, childCount: data.locationFilterList.length),
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.70,
                                            crossAxisSpacing: Dimentions.heightMargin10,
                                            mainAxisSpacing: Dimentions.heightMargin10),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text(
                                'no_data_found'.tr,
                                style: Theme.of(context).textTheme.headline2,
                              ));
                            }
                          }
                        })
                      : Consumer<LocationNotifier?>(builder: (context, data, _) {
                          if (data!.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            if (data.locationList.isNotEmpty) {
                              return Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: Dimentions.widthMargin15, right: Dimentions.widthMargin15),
                                  child: CustomScrollView(
                                    controller: _controller,
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    slivers: [
                                      SliverGrid(
                                        delegate: SliverChildBuilderDelegate((context, index) {
                                          return locationCell(themeProvider, index, data.locationList);
                                        }, childCount: data.locationList.length),
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.70,
                                            crossAxisSpacing: Dimentions.heightMargin10,
                                            mainAxisSpacing: Dimentions.heightMargin10),
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
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text(
                                'no_data_found'.tr,
                                style: Theme.of(context).textTheme.headline2,
                              ));
                            }
                          }
                        }))
            ],
          ),
        ),
      ),
    );
  }

  Widget locationCell(ThemeProvider themeProvider, int index, List<LocationData> locationList) {
    final String? title = locationList[index].title;
    final String? address1 = locationList[index].address1;
    final String? address2 = locationList[index].address2;
    final String? addressContent = parseHtmlString('$address1$address2');
    final String? imageUrl = locationList[index].image;
    final String? url = locationList[index].websiteUrl;
    final String? email = locationList[index].email;
    final String? latitude = locationList[index].lat;
    final String? longitude = locationList[index].long;
    final String? phone1 = locationList[index].telephone1;
    final String? phone2 = locationList[index].telephone2;
    final String? phone3 = locationList[index].telephone3;
    return Container(
        child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: DecoratedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                          height: 100.h,
                          width: double.maxFinite,
                          memCacheHeight: 500,
                          memCacheWidth: 500,
                          fit: BoxFit.cover,
                          imageUrl: imageUrl.toString(),
                          errorWidget: (context, url, error) => const Icon(Icons.error)),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              shareLocationData(locationList, index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(height: 20.h, width: 20.w, 'assets/images/share.png'),
                            ),
                          ))
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
                      child: Text(
                        title!,
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
                      child: Text(
                        addressContent!,
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  )
                ],
              )),
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.10) : const Color(0xFFF1F1F1),
                      ),
                    ),
                    // ignore: prefer_if_elements_to_conditional_expressions
                    url!.isEmpty
                        ? Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            GestureDetector(
                              onTap: () {
                                launchEmail(email);
                              },
                              child: Image.asset('assets/images/email.png'),
                            ),
                            GestureDetector(
                              onTap: () {
                                launchGoogleMap(latitude, longitude);
                              },
                              child: Image.asset('assets/images/location_pin.png'),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (phone1!.isNotEmpty || phone2!.isNotEmpty || phone3!.isNotEmpty) {
                                  modalPhoneNumberBottomSheetMenu(themeProvider, phone1, phone2, phone3);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Phone Number Not Available')));
                                }
                              },
                              child: Image.asset('assets/images/call_phone.png'),
                            )
                          ])
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  launchWebsiteUrl(url);
                                },
                                child: Image.asset('assets/images/website.png'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  launchEmail(email);
                                },
                                child: Image.asset('assets/images/email.png'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  launchGoogleMap(latitude, longitude);
                                },
                                child: Image.asset('assets/images/location_pin.png'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (phone1!.isNotEmpty || phone2!.isNotEmpty || phone3!.isNotEmpty) {
                                    modalPhoneNumberBottomSheetMenu(themeProvider, phone1, phone2, phone3);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Phone Number Not Available')));
                                  }
                                },
                                child: Image.asset('assets/images/call_phone.png'),
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          gradient: LinearGradient(
            colors: [
              if (themeProvider.isDarkMode) const Color(0xFF373A40) else const Color(0xFFFFFFFF),
              if (themeProvider.isDarkMode) const Color(0xFF13161D) else const Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    ));
  }

  Widget locationFilterCell(ThemeProvider themeProvider, int index, List<LocationFilterData> locationList) {
    final String? title = locationList[index].title;
    final String? address1 = locationList[index].address1;
    final String? address2 = locationList[index].address2;
    final String? addressContent = parseHtmlString('$address1$address2');
    final String? imageUrl = locationList[index].image;
    final String? url = locationList[index].websiteUrl;
    final String? email = locationList[index].email;
    final String? latitude = locationList[index].lat;
    final String? longitude = locationList[index].long;
    final String? phone1 = locationList[index].telephone1;
    final String? phone2 = locationList[index].telephone2;
    final String? phone3 = locationList[index].telephone3;

    return Container(
        child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: DecoratedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                          height: 100.h,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                          memCacheHeight: 500,
                          memCacheWidth: 500,
                          imageUrl: imageUrl.toString(),
                          errorWidget: (context, url, error) => const Icon(Icons.error)),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              shareLocationFilterData(locationList, index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(height: 20.h, width: 20.w, 'assets/images/share.png'),
                            ),
                          ))
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
                      child: Text(
                        title!,
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
                      child: Text(
                        addressContent!,
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  )
                ],
              )),
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.10) : const Color(0xFFF1F1F1),
                      ),
                    ),
                    // ignore: prefer_if_elements_to_conditional_expressions
                    url!.isEmpty
                        ? Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            GestureDetector(
                              onTap: () {
                                launchEmail(email);
                              },
                              child: Image.asset('assets/images/email.png'),
                            ),
                            GestureDetector(
                              onTap: () {
                                launchGoogleMap(latitude, longitude);
                              },
                              child: Image.asset('assets/images/location_pin.png'),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (phone1!.isNotEmpty || phone2!.isNotEmpty || phone3!.isNotEmpty) {
                                  modalPhoneNumberBottomSheetMenu(themeProvider, phone1, phone2, phone3);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Phone Number Not Available')));
                                }
                              },
                              child: Image.asset('assets/images/call_phone.png'),
                            )
                          ])
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  launchWebsiteUrl(url);
                                },
                                child: Image.asset('assets/images/website.png'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  launchEmail(email);
                                },
                                child: Image.asset('assets/images/email.png'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  launchGoogleMap(latitude, longitude);
                                },
                                child: Image.asset('assets/images/location_pin.png'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (phone1!.isNotEmpty || phone2!.isNotEmpty || phone3!.isNotEmpty) {
                                    modalPhoneNumberBottomSheetMenu(themeProvider, phone1, phone2, phone3);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Phone Number Not Available')));
                                  }
                                },
                                child: Image.asset('assets/images/call_phone.png'),
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          gradient: LinearGradient(
            colors: [
              if (themeProvider.isDarkMode) const Color(0xFF373A40) else const Color(0xFFFFFFFF),
              if (themeProvider.isDarkMode) const Color(0xFF13161D) else const Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    ));
  }

  Future<void> shareLocationFilterData(List<LocationFilterData> list, int? index) async {
    final String? title = list[index!].title;
    final String? address =
        '${list[index].address1} \n ${list[index].address2} \n ${list[index].city} \n ${list[index].state} - ${list[index].postcode} \n ${list[index].country}';
    final String? phone = '${list[index].telephone1} \n ${list[index].telephone2} \n ${list[index].telephone3}';
    final String? website = list[index].websiteUrl;
    final String? data = '$title \n\n $address \n\n $phone';
    await FlutterShare.share(title: 'Share Here', linkUrl: website, text: '$data');
  }

  Future<void> shareLocationData(List<LocationData> list, int? index) async {
    final String? title = list[index!].title;
    final String? address =
        '${list[index].address1} \n ${list[index].address2} \n ${list[index].city} \n ${list[index].state} - ${list[index].postcode} \n ${list[index].country}';
    final String? phone = '${list[index].telephone1} \n ${list[index].telephone2} \n ${list[index].telephone3}';
    final String? website = list[index].websiteUrl;
    final String? data = '$title \n\n $address \n\n $phone';
    await FlutterShare.share(title: 'Share Here', linkUrl: website, text: '$data');
  }

  Future<void> launchWebsiteUrl(String? url) async {
    Uri? uri;
    if (url!.isNotEmpty) {
      if (url.contains('https://')) {
        uri = Uri.parse(url);
      } else {
        uri = Uri.parse('https://$url');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid website url')));
    }
    if (!await launchUrl(uri!)) {
      throw 'Could not launch $uri';
    } else {
      debugPrint('Launch $uri');
    }
  }

  Future<void> launchEmail(String? email) async {
    if (email!.isNotEmpty) {
      final Uri emailLaunchUri = Uri(scheme: 'mailto', path: email);
      if (!await launchUrl(emailLaunchUri)) {
        throw 'Could not launch $emailLaunchUri';
      } else {
        debugPrint('Launch $emailLaunchUri');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid email address')));
    }
  }

  Future<void> launchGoogleMap(String? latitude, String? longitude) async {
    final String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  void modalPhoneNumberBottomSheetMenu(ThemeProvider themeProvider, String? phone1, String? phone2, String? phone3) {
    String _selectedPhoneNumber = phone1!;
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
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return FractionallySizedBox(
              heightFactor: 0.45,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: const EdgeInsets.all(10),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: themeProvider.isDarkMode ? const Color(0xFF262829) : const Color(0xFFFFFFFF),
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      // ignore: prefer_const_literals_to_create_immutables
                                      boxShadow: [
                                        const BoxShadow(
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
                                  'Please Select Phone Number',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Visibility(
                                    // ignore: avoid_bool_literals_in_conditional_expressions
                                    visible: phone1.isEmpty ? false : true,
                                    child: ListTile(
                                      leading: Radio<String>(
                                        value: phone1,
                                        groupValue: _selectedPhoneNumber,
                                        activeColor: CustomColors.OrangeColor,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedPhoneNumber = value!;
                                          });
                                        },
                                      ),
                                      title: Text(phone1),
                                    )),
                                Visibility(
                                  // ignore: avoid_bool_literals_in_conditional_expressions
                                  visible: phone2!.isEmpty ? false : true,
                                  child: ListTile(
                                    leading: Radio<String>(
                                      value: phone2,
                                      groupValue: _selectedPhoneNumber,
                                      activeColor: CustomColors.OrangeColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedPhoneNumber = value!;
                                        });
                                      },
                                    ),
                                    title: Text(phone2),
                                  ),
                                ),
                                Visibility(
                                  // ignore: avoid_bool_literals_in_conditional_expressions
                                  visible: phone3!.isEmpty ? false : true,
                                  child: ListTile(
                                    leading: Radio<String>(
                                      value: phone3,
                                      groupValue: _selectedPhoneNumber,
                                      activeColor: CustomColors.OrangeColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedPhoneNumber = value!;
                                        });
                                      },
                                    ),
                                    title: Text(phone3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                makePhoneCall(_selectedPhoneNumber);
                              },
                              child: Container(
                                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: SizedBox(
                                  width: 250.w,
                                  height: 25.h,
                                  child: Text('Call',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline2!.apply(color: CustomColors.ColorWhite)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            );
          });
        });
  }

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void modalBottomSheetMenu(ThemeProvider themeProvider, RegionFilterModel? regionFilterModel) {
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
          heightFactor: 0.6,
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
                          child: Container(
                              margin: const EdgeInsets.all(10),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: themeProvider.isDarkMode ? const Color(0xFF262829) : const Color(0xFFFFFFFF),
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  // ignore: prefer_const_literals_to_create_immutables
                                  boxShadow: [
                                    const BoxShadow(
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
                            'Filter',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _multiSelectController.deselectAll();
                            setState(() {
                              regionId = '';
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                            child: Text(
                              'RESET',
                              style: Theme.of(context).textTheme.headline2!.apply(color: CustomColors.OrangeColor),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'category'.tr,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MultiSelectContainer(
                          controller: _multiSelectController,
                          singleSelectedItem: true,
                          textStyles: MultiSelectTextStyles(
                            selectedTextStyle: Theme.of(context).textTheme.headline5!.apply(color: CustomColors.ColorWhite),
                            textStyle: Theme.of(context).textTheme.headline5!.apply(color: CustomColors.OrangeColor),
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
                          items: List.generate(regionFilterModel!.data!.length, (index) {
                            return MultiSelectCard(
                              value: regionFilterModel.data![index].id.toString(),
                              label: regionFilterModel.data![index].name.toString(),
                              // ignore: avoid_bool_literals_in_conditional_expressions
                              selected: regionId == regionFilterModel.data![index].id ? true : false,
                              decorations: MultiSelectItemDecorations(
                                decoration:
                                    BoxDecoration(border: Border.all(color: CustomColors.OrangeColor), borderRadius: BorderRadius.circular(20)),
                                selectedDecoration: BoxDecoration(color: CustomColors.OrangeColor, borderRadius: BorderRadius.circular(20)),
                              ),
                            );
                          }),
                          onChange: (allSelectedItems, selectedItem) {
                            setState(() {
                              regionId = '$selectedItem';
                            });
                          }),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (regionId == '') {
                            setState(() {
                              isFilterApply = false;
                            });
                            Navigator.pop(context);
                            fetchData(true, false);
                          } else {
                            setState(() {
                              isFilterApply = true;
                            });
                            Navigator.pop(context);
                            fetchLocationFilterData();
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: SizedBox(
                            width: 250.w,
                            height: 25.h,
                            child: Text('APPLY',
                                textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline2!.apply(color: CustomColors.ColorWhite)),
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
}
