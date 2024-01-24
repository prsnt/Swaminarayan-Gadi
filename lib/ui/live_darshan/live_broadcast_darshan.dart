import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LiveBroadCastDarshan extends StatefulWidget {
  const LiveBroadCastDarshan({Key? key, required this.youtubeId}) : super(key: key);
  final String youtubeId;

  @override
  _LiveBroadCastDarshanState createState() => _LiveBroadCastDarshanState();
}

class _LiveBroadCastDarshanState extends State<LiveBroadCastDarshan> {
  YoutubePlayerController? controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(autoPlay: true),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBarCustom(
              title: 'live_broadcast'.tr,
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
              child: YoutubePlayer(
                controller: controller!,
                showVideoProgressIndicator: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
