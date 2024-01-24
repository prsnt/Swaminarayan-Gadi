import 'package:appstructure/data/network/apis/daily_darshan/daily_darshan_notifier.dart';
import 'package:appstructure/ui/daily_darshan/live_stream_player.dart';
import 'package:flu_wake_lock/flu_wake_lock.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../widgets/appbar.dart';

class KadiMandirDarshan extends StatefulWidget {
  const KadiMandirDarshan({super.key});

  @override
  State<KadiMandirDarshan> createState() => _KadiMandirDarshanState();
}

class _KadiMandirDarshanState extends State<KadiMandirDarshan> {
  FluWakeLock _fluWakeLock = FluWakeLock();

  @override
  void initState() {
    super.initState();
    _fluWakeLock.enable();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchDailyDarshanKadiMandirData();
    });
  }

  Future<void> fetchDailyDarshanKadiMandirData() async {
    await Provider.of<DailyDarshanNotifier>(context, listen: false).fetchDailyDarshanKadiMandirData();
  }

  @override
  void dispose() {
    _fluWakeLock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
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
            child: Consumer<DailyDarshanNotifier>(
              builder: (context, dailyDarshan, _) {
                if (dailyDarshan.loading) {
                  return const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return LiveStreamPlayer(
                    streamUrl: (dailyDarshan.dailyDarshanKadiMandirModel?.data?[0].liveJson?[0].stream ?? '').toString(),
                    isStream: (dailyDarshan.dailyDarshanKadiMandirModel?.data?[0].liveJson?[0].isStream ?? '').toString(),
                    index: 0,
                  );
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
