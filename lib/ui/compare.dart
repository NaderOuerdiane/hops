import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hops/components/compare_widget.dart';
import 'package:hops/models/hop_model.dart';
import 'package:hops/repository/hops_repository.dart';
import 'package:hops/repository/page_repository.dart';
import 'package:provider/provider.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class ComparePage extends StatefulWidget {
  @override
  _ComparePageState createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  LinkedScrollControllerGroup _controllers;
  ScrollController controller1;
  ScrollController controller2;
  int _index = 0;

  @override
  void initState() {
    _controllers = LinkedScrollControllerGroup();
    controller1 = _controllers.addAndGet();
    controller2 = _controllers.addAndGet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final page = Provider.of<PageRepository>(context, listen: false);
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final double width = MediaQuery.of(context).size.width;
    final HopsRepository hops = Provider.of<HopsRepository>(context);
    bool alternate = false;
    List<Hop> cmpsHops = hops.cmps
        .map<Hop>(
            (cmp) => hops.hops.singleWhere((element) => element.variety == cmp))
        .toList();

    return SafeArea(
      child: cmpsHops.isEmpty
          ? Stack(
              children: <Widget>[
                Positioned(
                  height: height * 0.1,
                  width: width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            page.changePage(0);
                            page.tab ? page.changeTab() : null;
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 24, top: 24),
                            child: Image.asset('assets/images/back2.png',
                                height: height * 0.06),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => page.changePage(0),
                          child: Container(
                            color: Colors.white,
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 24, right: 12),
                                    child: Text(
                                      'clear all',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 24, top: 24),
                                    child: Image.asset(
                                      'assets/images/back.png',
                                      color: Theme.of(context).primaryColor,
                                      height: height * 0.06,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ]),
                ),
              ],
            )
          : Stack(
              children: <Widget>[
                Positioned(
                  height: height * 0.1,
                  width: width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            page.changePage(0);
                            page.tab ? page.changeTab() : null;
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 24, top: 24),
                            child: Image.asset('assets/images/back2.png',
                                height: height * 0.06),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            hops.clearCompare();
                            page.changePage(0);
                          },
                          child: Container(
                            color: Colors.white,
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 24, right: 12),
                                    child: Text(
                                      'clear all',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 24, top: 24),
                                    child: Image.asset(
                                      'assets/images/back.png',
                                      color: Theme.of(context).primaryColor,
                                      height: height * 0.06,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ]),
                ),
                Positioned(
                    top: height * 0.125,
                    height: height * 0.4,
                    width: height * 0.4,
                    right: width * 0.55 - height * 0.025,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFeaf2eb).withOpacity(0.3),
                                Color(0xFFa9bbb5).withOpacity(0.3),
                              ])),
                    )),
                Positioned(
                  top: height * 0.15,
                  height: height * 0.35,
                  width: height * 0.35,
                  right: width * 0.55,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Container(
                        padding: EdgeInsets.all(height * 0.045),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFeaf2eb).withOpacity(0.5),
                                  Color(0xFFa9bbb5).withOpacity(0.5),
                                ])),
                        child: Stack(children: [
                          Opacity(
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(
                                    sigmaX: 12.5, sigmaY: 12.5),
                                child: Image.asset('assets/images/hop2.png',
                                    color: Colors.black),
                              ),
                              opacity: 1),
                          Image.asset(
                            'assets/images/hop2.png',
                          ),
                        ])),
                  ),
                ),
                Positioned(
                    top: height * 0.125,
                    left: 32,
                    child: Text(
                      '${cmpsHops[0].variety ?? ''}',
                      style: Theme.of(context).textTheme.headline1,
                    )),
                Positioned(
                    top: height * 0.55,
                    left: 12,
                    right: width * 0.5,
                    bottom: 0,
                    child: ListView(
                      controller: controller1,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Alpha Acids Min : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].alpha_min.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Alpha Acids Max : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].alpha_max.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Beta Acids Min : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].beta_min.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Beta Acids Min : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].beta_max.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Total oil Min : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].total_oil_min.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Total oil Max : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].total_oil_max.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Cohumulone Min : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].cohumulone_min.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Cohumulone Max : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].cohumulone_max.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'B-Pinene Min : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].b_pinene_min.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'B-Pinene Max : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].b_pinene_max.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Myrcene Min : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].myrcene_min.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Myrcene Max : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].myrcene_max.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Linalool Min : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].linalool_min.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Linalool Max : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].linalool_max.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Caryiohyllene Min : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].caryphyllene_min.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Caryophyllene Max : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].caryphyllene_max.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Farnesene Min : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].farnesene_min.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Farnesene Max : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].farnesene_max.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Humulene Min : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].humulene_min.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Humulene Max : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].humulene_max.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Geraniol Min : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].geraniol_min.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Geraniol Max : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].geraniol_max.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Selinene Min : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].selinene_min.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Selinene Max : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].selinene_max.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Other Min : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].other_min.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Other Max : ',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              cmpsHops[0].other_max.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                      ],
                    )),
                cmpsHops.length > 1
                    ? Positioned(
                        top: height * 0.225,
                        left: width * 0.55,
                        right: 0.0,
                        bottom: 0.0,
                        child: PageView.builder(
                          itemCount: cmpsHops.length - 1,
                          controller: PageController(viewportFraction: 1),
                          itemBuilder: (_, i) {
                            return CompareWidget(cmpsHops[0], cmpsHops[i + 1],
                                i % 2 == 0, controller2, i + 1, height);
                          },
                        ),

                        /*ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: cmpsHops.length - 1,
                          itemBuilder: (context, index) => CompareWidget(
                              cmpsHops[0],
                              cmpsHops[index + 1],
                              index % 2 == 0,
                              controller2,
                              index + 1,
                              height),
                        )*/
                      )
                    : Container()
              ],
            ),
    );
  }
}
