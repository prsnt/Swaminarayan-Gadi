import 'package:appstructure/ui/daily_darshan/live_darshan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liplayer/liplayer.dart';

class LiveStreamPlayer extends StatefulWidget {
  const LiveStreamPlayer({
    Key? key,
    required this.streamUrl,
    required this.isStream,
    required this.index,
  }) : super(key: key);
  final String streamUrl;
  final String isStream;
  final int index;

  @override
  _LiveStreamPlayerState createState() => _LiveStreamPlayerState();
}

class _LiveStreamPlayerState extends State<LiveStreamPlayer> with WidgetsBindingObserver {
  LiPlayer player = LiPlayer();
  bool _playerInitialized = false;
  final controller = Get.put(LiveDarshanController());

  @override
  void initState() {
    super.initState();
    player = LiPlayer();
    player.setDataSource(
      widget.streamUrl,
      autoPlay: true,
      showCover: true,
    );

    player.addListener(_playerListener);
    player.prepareAsync();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    player.removeListener(_playerListener);
    WidgetsBinding.instance.removeObserver(this);
    player.release();
    super.dispose();
  }

  void _playerListener() {
    if (player.state == LiState.started) {
      _playerInitialized = true;
      setState(() {});
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        player.setVolume(0);
        break;
      case AppLifecycleState.resumed:
        if (controller.selectedIndex.value == widget.index) {
          player.setVolume(100);
        } else {
          player.setVolume(0);
        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.selectedIndex.value == widget.index) {
          player.setVolume(100);
        } else {
          player.setVolume(0);
        }
        return Scaffold(
          body: SafeArea(
            child: widget.isStream == 'active'
                ? Stack(
                    children: [
                      if (_playerInitialized)
                        LiView(
                          fs: true,
                          player: player,
                          color: Colors.black,
                        ),
                      if (!_playerInitialized)
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.black,
                          child: const Center(
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                : Center(
                    child: Text(
                      'Live Darshan Stream not available at now',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
