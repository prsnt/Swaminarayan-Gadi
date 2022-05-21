library customloader;
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader(
      {required this.type,
        this.color = Colors.yellow,
        this.cornerRadius = 10,
        this.textColor = Colors.black,
        this.labelText = 'Please wait...'});

  final LoaderType type;
  final Color color;
  final double cornerRadius;
  final Color textColor;
  final String labelText;

  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

// input text state
class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // build method for UI rendering
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: Container(
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                  )),
            ],
          ),
          Center(
            child: Container(child: getLoaderBasedOnType()),
          ),
        ],
      ),
    );
  }

  Widget getLoaderBasedOnType() {
    if (widget.type == LoaderType.androidNative) {
      return androidLoadingIndicator();
    } else if (widget.type == LoaderType.iOSNative) {
      return iOSLoadingIndicator();
    } else if (widget.type == LoaderType.type1Loader) {
      return defaultLoadingIndicator(iconName: Icons.camera);
    } else if (widget.type == LoaderType.type2Loader) {
      return defaultLoadingIndicator(iconName: Icons.autorenew);
    } else if (widget.type == LoaderType.type3Loader) {
      return defaultLoadingIndicator(iconName: Icons.ac_unit);
    } else if (widget.type == LoaderType.type4Loader) {
      return defaultLoadingIndicator(iconName: Icons.toys);
    } else if (widget.type == LoaderType.type5Loader) {
      return defaultLoadingIndicator(iconName: Icons.track_changes);
    } else if (widget.type == LoaderType.type6Loader) {
      return defaultLoadingIndicator(iconName: Icons.wifi_tethering);
    } else if (widget.type == LoaderType.type7Loader) {
      return defaultLoadingIndicator(iconName: Icons.swap_horizontal_circle);
    } else if (widget.type == LoaderType.type8Loader) {
      return defaultLoadingIndicator(iconName: Icons.scatter_plot);
    }
    return Container();
  }

  Widget androidLoadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(widget.cornerRadius)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation<Color>(widget.color),
              ),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Text(widget.labelText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: widget.textColor)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget iOSLoadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(widget.cornerRadius)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoTheme(
                  data: CupertinoTheme.of(context)
                      .copyWith(brightness: Brightness.light),
                  child: const CupertinoActivityIndicator(radius: 30)),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Text(widget.labelText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: widget.textColor)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget defaultLoadingIndicator({IconData? iconName}) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(widget.cornerRadius)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    return Transform.rotate(
                        angle: _controller.value * 2 * math.pi, child: child);
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Icon(
                      iconName,
                      size: 70,
                      color: widget.color,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(widget.labelText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: widget.textColor)),
                  ),
                )
              ],
            ),
          ),
        ));
  }

}

//input types
enum LoaderType {
  iOSNative,
  androidNative,
  type1Loader,
  type2Loader,
  type3Loader,
  type4Loader,
  type5Loader,
  type6Loader,
  type7Loader,
  type8Loader
}
