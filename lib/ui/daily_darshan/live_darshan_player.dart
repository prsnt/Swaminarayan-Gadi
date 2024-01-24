import 'package:appstructure/ui/daily_darshan/live_darshan_controller.dart';
import 'package:flu_wake_lock/flu_wake_lock.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../data/network/apis/api_services.dart';
import '../../models/daily_darshan_model.dart';
import '../widgets/appbar.dart';
import 'live_stream_player.dart';

class LiveDarshanPlayer extends StatefulWidget {
  const LiveDarshanPlayer({super.key});

  @override
  State<LiveDarshanPlayer> createState() => _LiveDarshanPlayerState();
}

class _LiveDarshanPlayerState extends State<LiveDarshanPlayer> {
  List<LiveJson>? liveJsonList = [];
  bool isLoading = false;
  final FluWakeLock _fluWakeLock = FluWakeLock();
  int selectIndex = 0;
  final controller = Get.put(LiveDarshanController());

  @override
  void initState() {
    super.initState();
    _fluWakeLock.enable();
    setState(() {
      isLoading = true;
    });
    _fetchLiveDarshanData();
  }

  @override
  Future<void> dispose() async {
    _fluWakeLock.disable();
    super.dispose();
  }

  Future<void> _fetchLiveDarshanData() async {
    await getDailyDarshanData().then((value) async {
      value!.data!.map((e) {
        final Iterable<LiveJson> liveJsonLordSwminarayan = e.liveJson!.where((element) => element.title == 'Lord Swaminarayan');
        liveJsonLordSwminarayan.map((data) {
          liveJsonList!.add(data);
        }).toList();
        final Iterable<LiveJson> liveJsonHarikrishnaMaharaj = e.liveJson!.where((element) => element.title == 'Harikrushna Maharaj');
        liveJsonHarikrishnaMaharaj.map((data) {
          liveJsonList!.add(data);
        }).toList();
        final Iterable<LiveJson> liveJsonSahajanandSwami = e.liveJson!.where((element) => element.title == 'Sahajanand Swami');
        liveJsonSahajanandSwami.map((data) {
          liveJsonList!.add(data);
        }).toList();
      }).toList();

      await getDailyDarshanManinagarData().then((value) {
        value!.data!.map((e) {
          e.liveJson!.map((liveJson) {
            liveJsonList!.add(liveJson);
          }).toList();
        }).toList();
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Column(
                children: [
                  AppBarCustom(
                    title: 'live_darshan'.tr,
                    isBack: true,
                    isSearch: false,
                    isFilter: false,
                    backCallback: () {
                      Navigator.of(context).pop(true);
                    },
                    filterCallBack: () {},
                    searchCallBack: () {},
                  ),
                  const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ],
              )
            : Column(
                children: [
                  AppBarCustom(
                    title: 'live_darshan'.tr,
                    isBack: true,
                    isSearch: false,
                    isFilter: false,
                    backCallback: () {
                      Navigator.of(context).pop(true);
                    },
                    filterCallBack: () {},
                    searchCallBack: () {},
                  ),
                  Expanded(
                    child: PreloadPageView.builder(
                      controller: PreloadPageController(),
                      preloadPagesCount: liveJsonList?.length ?? 4,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (value) {
                        controller.selectedIndex.value = value;
                      },
                      itemBuilder: (context, index) {
                        return LiveStreamPlayer(
                          streamUrl: liveJsonList?[index].stream.toString() ?? '',
                          isStream: liveJsonList?[index].isStream.toString() ?? '',
                          index: index,
                        );
                      },
                      itemCount: liveJsonList?.length ?? 4,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
