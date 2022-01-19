// ignore_for_file: deprecated_member_use

import 'package:intl/intl.dart';

import '../providers/Hardware.dart';
import '../PC_Builder_app_theme.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:best_flutter_ui_templates/PC_Builder/providers/Hardware_provider.dart';
import '../Screens/Hardware_info_screen.dart';
import '../providers/Models.dart';

class HardwareListView extends StatefulWidget {
  const HardwareListView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;
  @override
  _HardwareListViewState createState() => _HardwareListViewState();
}

class _HardwareListViewState extends State<HardwareListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hardwaredata = Provider.of<hardware>(context);
    final hardwares = hardwaredata.items;

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
                itemCount: hardwares.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      hardwares.length > 10 ? 10 : hardwares.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();
                  return HardwareView(
                    hardwareitem: hardwares[index],
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

class HardwareView extends StatelessWidget {
  const HardwareView(
      {Key? key,
      this.hardwareitem,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final Hardware? hardwareitem;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    final models = Provider.of<Models>(context);
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
              // ----------------------------
              // ---------- prob-------------------
              // -------------------------------------------------
              onTap: () => Navigator.of(context).pushNamed(
                  HardwareInfoScreen.routName,
                  arguments: hardwareitem!.id),
              // ------------------------------------------------------
              // ----------------------------------------------------
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
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: Text(
                                              hardwareitem!.Type.length <= 16
                                                  ? hardwareitem!.Type
                                                  : hardwareitem!.Type
                                                      .substring(0, 16),
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
                                                  '💲${hardwareitem!.price} ',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 12,
                                                    letterSpacing: 0.23,
                                                    color:
                                                        PCBuilderAppTheme.grey,
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        '${hardwareitem!.Rating.toString().substring(0, 4)}',
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
                                                        color: PCBuilderAppTheme
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
                                                  '${hardwareitem!.prop1![0]}',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10,
                                                    letterSpacing: 0.27,
                                                    color:
                                                        PCBuilderAppTheme.grey,
                                                  ),
                                                ),
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  alignment: Alignment.topRight,
                                                  decoration: BoxDecoration(
                                                    color: PCBuilderAppTheme
                                                        .nearlyBlue,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                8.0)),
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      models.addItem(
                                                          hardwareitem!.id,
                                                          hardwareitem!.price,
                                                          hardwareitem!.Type,
                                                          hardwareitem!.Rating,
                                                          hardwareitem!
                                                              .Imageurl,
                                                          hardwareitem!.color,
                                                          hardwareitem!.swhw,
                                                          null,
                                                          hardwareitem!.prop1,
                                                          hardwareitem!.prop2,
                                                          hardwareitem!.prop3);
                                                      Scaffold.of(context)
                                                          .hideCurrentSnackBar();

                                                      Scaffold.of(context)
                                                          // ignore: deprecated_member_use
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: Text(
                                                          "Added item to Model",
                                                        ),
                                                        action: SnackBarAction(
                                                          label: ' UNDO',
                                                          onPressed: () {
                                                            models.removeItem(
                                                                hardwareitem!
                                                                    .id);
                                                          },
                                                        ),
                                                        duration: Duration(
                                                            seconds: 2),
                                                      ));
                                                    },
                                                    //                           Center(
                                                    //   child: Padding(
                                                    //     padding: const EdgeInsets.all(4.0),
                                                    //     child: Icon(
                                                    //                             Icons.add,
                                                    //                             color: PCBuilderAppTheme
                                                    //                                 .nearlyWhite,
                                                    //                             //  semanticLabel: ,
                                                    //                           ),
                                                    //                         ),
                                                    //     ),
                                                    //   ),
                                                    // )
                                                    icon: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 100,
                                                                right: 12),
                                                        child: Icon(
                                                          Icons.add,
                                                          color:
                                                              PCBuilderAppTheme
                                                                  .nearlyWhite,
                                                          //  semanticLabel: ,
                                                        ),
                                                      ),
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              child: AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Image.asset(hardwareitem!.Imageurl)),
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
  }
}
