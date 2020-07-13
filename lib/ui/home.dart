import 'package:flutter/material.dart';
import 'package:hops/components/hop_widget.dart';
import 'package:hops/components/loading_widget.dart';
import 'package:hops/repository/hops_repository.dart';
import 'package:hops/repository/page_repository.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final page = Provider.of<PageRepository>(context, listen: false);
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    bool alternate = false;
    return FutureBuilder(
      future: Provider.of<HopsRepository>(context).loadAsset(),
      builder: (context, snapshot) => snapshot.data == false
          ? LoadingElement()
          : Consumer<HopsRepository>(builder: (context, hops, child) {
              return SafeArea(
                child: ListView(children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 24, top: 24),
                          child: Text(
                            'HopStar',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                                onTap: () => page.changePage(3),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                        child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 24, 16, 0),
                                      child: Image.asset(
                                        'assets/images/compare-icon.png',
                                        height: height * 0.0475,
                                      ),
                                    )),
                                    hops.cmps.length != 0
                                        ? Positioned(
                                            right: 6,
                                            top: 20,
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context)
                                                      .primaryColorLight),
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(
                                                  hops.cmps.length == 1
                                                      ? 5
                                                      : 2),
                                              child: Text(
                                                hops.cmps.length == 1
                                                    ? '*'
                                                    : '${hops.cmps.length - 1}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        : Container()
                                  ],
                                )),
                            GestureDetector(
                              onTap: () => page.changeTab(),
                              child: Container(
                                margin: EdgeInsets.only(right: 24, top: 24),
                                child: Image.asset(
                                  'assets/images/tab.png',
                                  color: Theme.of(context).primaryColor,
                                  height: height * 0.06,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                  Container(
                      margin: EdgeInsets.only(top: 36, left: 24),
                      child: Text('Aroma',
                          style: Theme.of(context).textTheme.headline3)),
                  Container(
                    height: height * 0.54,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        ...hops.hops
                            .where((element) => element.type == 'Aroma')
                            .map((e) {
                          alternate = !alternate;
                          return HopWidget(e, hops, alternate);
                        }).toList()
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 24, left: 24),
                      child: Text('Bittering',
                          style: Theme.of(context).textTheme.headline3)),
                  Container(
                    height: height * 0.54,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        ...hops.hops
                            .where((element) => element.type == 'Bittering')
                            .map((e) {
                          alternate = !alternate;
                          return HopWidget(e, hops, alternate);
                        }).toList()
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 24, left: 24),
                      child: Text('Dual',
                          style: Theme.of(context).textTheme.headline3)),
                  Container(
                    height: height * 0.54,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        ...hops.hops
                            .where((element) =>
                                element.type == "Bittering\", \"Aroma")
                            .map((e) {
                          alternate = !alternate;
                          return HopWidget(e, hops, alternate);
                        }).toList()
                      ],
                    ),
                  ),
                ]),
              );
            }),
    );
  }
}
