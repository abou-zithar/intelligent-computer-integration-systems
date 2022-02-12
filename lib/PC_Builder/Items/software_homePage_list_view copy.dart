// ignore_for_file: deprecated_member_use

import 'package:best_flutter_ui_templates/PC_Builder/Screens/Software_info_screen.dart';
import 'package:best_flutter_ui_templates/PC_Builder/providers/software.dart';
import 'package:best_flutter_ui_templates/PC_Builder/providers/software_provider.dart';

import '../PC_Builder_app_theme.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Models.dart';

class SoftwareListView extends StatefulWidget {
  const SoftwareListView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;
  @override
  _SoftwareListViewState createState() => _SoftwareListViewState();
}

class _SoftwareListViewState extends State<SoftwareListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 150));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final softwaredata = Provider.of<software>(context);
    final softwares = softwaredata.items;

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Container(
        height: 134,
        width: double.infinity,
        child: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: softwares.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      softwares.length > 10 ? 10 : softwares.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();
                  return SoftwareView(
                    softwareitem: softwares[index],
                    animation: animation,
                    animationController: animationController,
                    callback: widget.callBack,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class SoftwareView extends StatelessWidget {
  const SoftwareView(
      {Key? key,
      this.softwareitem,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final Software? softwareitem;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    final models = Provider.of<Models>(context);
    if (softwareitem!.rating > 4) {
      return AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: animation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  100 * (1.0 - animation!.value), 0.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                // ---------- solved prob-------------------
                // -------------------------------------------------
                onTap: () => Navigator.of(context).pushNamed(
                    SoftwareInfoScreen.routName,
                    arguments: softwareitem!.id),
                // ------------------------------------------------------
                child: SizedBox(
                  width: 280,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 38,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: HexColor('#F8FAFB'),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    const SizedBox(
                                      width: 48 + 24.0,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16),
                                              child: Text(
                                                softwareitem!.title.length <= 11
                                                    ? softwareitem!.title
                                                    : softwareitem!.title
                                                        .substring(0, 11),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  letterSpacing: 0.27,
                                                  color: PCBuilderAppTheme
                                                      .darkerText,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 18, bottom: 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    '💲${softwareitem!.price} ',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      fontSize: 12,
                                                      letterSpacing: 0.23,
                                                      color: PCBuilderAppTheme
                                                          .grey,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          '${softwareitem!.rating.toString().substring(0, 4)}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w200,
                                                            fontSize: 18,
                                                            letterSpacing: 0.0,
                                                            color:
                                                                PCBuilderAppTheme
                                                                    .grey,
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color:
                                                              PCBuilderAppTheme
                                                                  .nearlyBlue,
                                                          size: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 26, right: 26),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    '${softwareitem!.prop1![0]}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 10,
                                                      letterSpacing: 0.27,
                                                      color: PCBuilderAppTheme
                                                          .grey,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 30,
                                                    height: 30,
                                                    alignment:
                                                        Alignment.topRight,
                                                    decoration: BoxDecoration(
                                                      color: PCBuilderAppTheme
                                                          .nearlyBlue,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  8.0)),
                                                    ),
                                                    child: IconButton(
                                                      iconSize: 15,
                                                      onPressed: () {
                                                        models.addItem(
                                                            softwareitem!.id,
                                                            softwareitem!.price,
                                                            softwareitem!.title,
                                                            softwareitem!
                                                                .rating,
                                                            softwareitem!
                                                                .imagePath,
                                                            softwareitem!.color,
                                                            softwareitem!.swhw,
                                                            null,
                                                            softwareitem!.prop1,
                                                            softwareitem!.prop2,
                                                            softwareitem!
                                                                .prop3);
                                                        Scaffold.of(context)
                                                            .hideCurrentSnackBar();

                                                        Scaffold.of(context)
                                                            // ignore: deprecated_member_use
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                            "Added item to Model",
                                                          ),
                                                          action:
                                                              SnackBarAction(
                                                            label: ' UNDO',
                                                            onPressed: () {
                                                              models.removeItem(
                                                                  softwareitem!
                                                                      .id);
                                                            },
                                                          ),
                                                          duration: Duration(
                                                              seconds: 2),
                                                        ));
                                                      },
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: PCBuilderAppTheme
                                                            .nearlyWhite,
                                                        //  semanticLabel: ,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 24, bottom: 24, left: 16),
                          child: Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                child: AspectRatio(
                                    aspectRatio: 1.0,
                                    child:
                                        Image.network(softwareitem!.imagePath)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return SizedBox(
        height: 10,
      );
    }
  }
}
