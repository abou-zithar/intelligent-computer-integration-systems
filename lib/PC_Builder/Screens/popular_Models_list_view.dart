import 'package:best_flutter_ui_templates/PC_Builder/providers/pcModel.dart';
import 'package:best_flutter_ui_templates/PC_Builder/providers/user_model.dart';
import 'package:provider/provider.dart';

import '../PC_Builder_app_theme.dart';
import '../../main.dart';
import 'package:flutter/material.dart';

class PopularModelListView extends StatefulWidget {
  const PopularModelListView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;
  @override
  _PopularModelListViewState createState() => _PopularModelListViewState();
}

class _PopularModelListViewState extends State<PopularModelListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final finalmodel = Provider.of<PcModel>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return GridView(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                finalmodel.items.length,
                (int index) {
                  final int count = finalmodel.items.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController!,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController?.forward();
                  return CategoryView(
                    callback: widget.callBack,
                    model: finalmodel.items[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 32.0,
                childAspectRatio: 0.8,
              ),
            );
          }
        },
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key? key,
      this.model,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final PcModel? model;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: callback,
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#F8FAFB'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                // border: new Border.all(
                                //     color: DesignCourseAppTheme.notWhite),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, left: 16, right: 16),
                                            child: Text(
                                              'model ${model!.Title}',
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
                                                top: 8,
                                                left: 16,
                                                right: 16,
                                                bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '${model!.Price < int.parse(user.budget) ? model!.Price.toString().substring(0, 4) : 'this model is over your budget'}',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 10,
                                                    letterSpacing: 0.27,
                                                    color:
                                                        PCBuilderAppTheme.grey,
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        '${model!.Rate.toString().substring(0, 4)}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 14,
                                                          letterSpacing: 0.27,
                                                          color:
                                                              PCBuilderAppTheme
                                                                  .grey,
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: PCBuilderAppTheme
                                                            .nearlyBlue,
                                                        size: 18,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 48,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            child: AspectRatio(
                                aspectRatio: 1.28,
                                child: Image.asset(
                                    'assets/new_images/computer.png')),
                          ),
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
