import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const Color blueColor = Color(0xff00AFF0);

class ConfirmationPopUp extends StatelessWidget {
  const ConfirmationPopUp(
      {this.title,
        this.message,
        this.buttonTitles,
        this.optionDidSelected});

  final String? title;
  final String? message;
  final List<String>? buttonTitles;
  final Function? optionDidSelected;

  Widget popUpWidget() => Stack(
        children: <Widget>[
          Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.8)),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Stack(
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.center,
                fit: StackFit.loose,
                children: <Widget>[
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            height: 70,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                blueColor.withOpacity(1),
                                blueColor.withOpacity(0.8),
                                blueColor.withOpacity(0.6),
                                blueColor.withOpacity(0.4),
                              ]),
                            )),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(title ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25)),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(message ?? '',
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        const SizedBox(height: 50),
                        Container(
                          height: 50,
                          width: double.infinity,
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(25),
                              gradient: LinearGradient(colors: [
                                blueColor.withOpacity(1),
                                blueColor.withOpacity(0.8),
                                blueColor.withOpacity(0.6),
                                blueColor.withOpacity(0.4),
                              ])),
                          child: FlatButton(
                              onPressed: () {
                                if (optionDidSelected != null) {
                                  optionDidSelected!();
                                }
                              },
                              child: Text(
                                buttonTitles != null && buttonTitles!.isNotEmpty ? buttonTitles![0] : 'Yes',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 50,
                          width: double.infinity,
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(25),
                            color: Colors.grey,
                          ),
                          child: FlatButton(
                              onPressed: () {
                                if (optionDidSelected != null) {
                                  optionDidSelected!();
                                }
                              },
                              child: Text(
                                buttonTitles != null && buttonTitles!.length > 1 ? buttonTitles![1] : 'No',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: popUpWidget(),
    );
  }
}

class InformativePopUp extends StatelessWidget {
  const InformativePopUp(
      {this.title,
        this.message,
        this.buttonTitle = 'OK',
        this.optionDidSelected});

  final String? title;
  final String? message;
  final String buttonTitle;
  final Function? optionDidSelected;

  Widget popUpWidget() => Stack(
    clipBehavior: Clip.hardEdge,
    children: <Widget>[
      Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black.withOpacity(0.8)),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                clipBehavior: Clip.hardEdge,
                fit: StackFit.loose,
                children: <Widget>[
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 100),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(title ?? '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25)),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(message ?? '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 20)),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 25, color: Colors.transparent)
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 30,
                      right: 30,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadiusDirectional.circular(25),
                          color: blueColor,
                        ),
                        child: FlatButton(
                            onPressed: () {
                              if (optionDidSelected != null) {
                                optionDidSelected!();
                              }
                            },
                            child: Text(
                              buttonTitle ?? '',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      )),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white, width: 1)),
                padding: const EdgeInsets.all(0),
                child: SizedBox.expand(
                  child: InkWell(
                      onTap: () {
                        if (optionDidSelected != null) {
                          optionDidSelected!();
                        }
                      },
                      child:
                      const Icon(Icons.clear, color: Colors.white, size: 30)),
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: popUpWidget(),
    );
  }
}

class ActivityPopUp extends StatelessWidget {
  const ActivityPopUp(
      {this.title,
        this.message,
        this.buttonTitle = 'OK',
        this.optionDidSelected});

  final String? title;
  final String? message;
  final String buttonTitle;
  final Function? optionDidSelected;

  Widget popUpWidget() => Stack(
    clipBehavior: Clip.hardEdge,
    children: <Widget>[
      Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black.withOpacity(0.8)),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                clipBehavior: Clip.hardEdge,
                fit: StackFit.loose,
                children: <Widget>[
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.deepPurple.withOpacity(0.4),
                              Colors.purple.withOpacity(0.4),
                              Colors.purple.withOpacity(0.6),
                              Colors.purple.withOpacity(0.8),
                              Colors.purple.withOpacity(1),
                            ]),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                               Icon(Icons.local_activity, color: Colors.white, size: 50),
                               SizedBox(height: 5),
                               Text('QUICK TIPS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))
                            ],
                          ),
                        ),
                        Container(
                          height: 300,
                          child: ListView.builder(
                              itemBuilder: (ctx, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Text('${index + 1}'),
                                    ),
                                    title: const Text('Post your photo'),
                                    subtitle:
                                    const Text('upload your profile picture.'),
                                  ),
                                );
                              },
                              itemCount: 5),
                        ),
                        Container(
                          height: 0.5,
                          width: double.infinity,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: FlatButton(onPressed: (){
                            if (optionDidSelected != null) {
                              optionDidSelected!();
                            }
                          }, child: const Text('CLOSE')),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: popUpWidget(),
    );
  }
}

class QuestionPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black.withOpacity(0.8),
        )
      ],
    );
  }
}

class DialogManager {
  void showAlertDialogue({required BuildContext ctx, PopUpData? data}) {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return data!.type == PopUpType.iOSStyle
              ? CupertinoAlertDialog(
                  title: Text(data.title ?? ''),
                  content: Text(data.message ?? ''),
                  actions: getActions(ctx: ctx, data: data),
                )
              : AlertDialog(
                  title: Text(data.title ?? ''),
                  content: Text(data.message ?? ''),
                  actions: getActions(ctx: ctx, data: data));
        });
  }

  List<Widget> getActions({BuildContext? ctx, required PopUpData data}) {
    final List<Widget> actions = [];
    if (data.options != null && data.options.isNotEmpty) {
      for (int index = 0; index < data.options.length; index++) {
        final action = data.type == PopUpType.iOSStyle
            ? CupertinoDialogAction(
                child: Text(data.options[index]),
                onPressed: () {
                  onPressed(
                      option: data.options[index],
                      ctx: ctx!,
                      function: data.selectionCallback);
                })
            : FlatButton(
                onPressed: () {
                  onPressed(
                      option: data.options[index],
                      ctx: ctx!,
                      function: data.selectionCallback);
                },
                child: Text(data.options[index]));
        actions.add(action);
      }
    }
    return actions;
  }

  void onPressed({String? option, required BuildContext ctx, Function? function}) {
    Navigator.of(ctx).pop();
    if (function != null) {
      function(option);
    }
  }

  void showActionSheetDialogue({required BuildContext ctx, PopUpData? data}) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text(data!.title ?? ''),
            message: Text(data.message ?? ''),
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                isDestructiveAction: true,
                child: const Text('Cancel')),
            actions: getActions(ctx: ctx, data: data),
          );
        });
  }
}

class PopUpData {
  PopUpData(
      {required this.title,
        required this.message,
        required this.options,
        required this.type,
        required this.selectionCallback});

  final String title;
  final String message;
  final List<String> options;
  final PopUpType type;
  final Function selectionCallback;
}

enum PopUpType { androidStyle, iOSStyle }
