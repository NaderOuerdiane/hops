import 'package:flutter/material.dart';
import 'package:hops/components/hop_widget.dart';
import 'package:hops/repository/hops_repository.dart';
import 'package:hops/repository/page_repository.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final page = Provider.of<PageRepository>(context, listen: false);
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    bool alternate = false;
    return SafeArea(
      child: ListView(children: <Widget>[
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      height: height * 0.07),
                ),
              ),
              InkWell(
                onTap: () => page.changeTab(),
                child: Container(
                  margin: EdgeInsets.only(right: 24, top: 24),
                  child: Image.asset(
                    'assets/images/tab.png',
                    color: Theme.of(context).primaryColor,
                    height: height * 0.07,
                  ),
                ),
              ),
            ]),
        Container(
            margin: EdgeInsets.only(top: 36, left: 24),
            child:
                Text('My stock', style: Theme.of(context).textTheme.headline1)),
        Consumer<HopsRepository>(
          builder: (context, hops, child) {
            return Container(
              height: height * 0.54,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ...hops.hops
                      .where((element) => hops.favs.contains(element.variety))
                      .map((e) {
                    alternate = !alternate;
                    return HopWidget(e, hops, alternate);
                  }).toList()
                ],
              ),
            );
          },
        ),
      ]),
    );
  }
}
