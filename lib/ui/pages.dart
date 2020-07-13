import 'package:flutter/material.dart';
import 'package:hops/repository/page_repository.dart';
import 'package:hops/ui/compare.dart';
import 'package:hops/ui/favorite.dart';
import 'package:hops/ui/home.dart';
import 'package:hops/ui/search.dart';
import 'package:provider/provider.dart';

class PagesPage extends StatefulWidget {
  @override
  _PagesPageState createState() => _PagesPageState();
}

class _PagesPageState extends State<PagesPage> {
  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final double width = MediaQuery.of(context).size.width;
    final page = Provider.of<PageRepository>(context);

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(children: <Widget>[
          page.page == PageSelect.Home
              ? HomePage()
              : page.page == PageSelect.Search
                  ? SearchPage()
                  : page.page == PageSelect.Favorite
                      ? FavoritePage()
                      : page.page == PageSelect.Compare
                          ? ComparePage()
                          : HomePage(),
          AnimatedContainer(
              margin: EdgeInsets.only(left: page.tab ? width * 0.5 : width),
              duration: Duration(milliseconds: 200),
              color: Theme.of(context).accentColor,
              width: width * 0.5,
              height: double.infinity,
              child: Stack(children: <Widget>[
                Positioned(
                    top: page.page == PageSelect.Home
                        ? height * 0.295
                        : page.page == PageSelect.Search
                            ? height * 0.365
                            : page.page == PageSelect.Favorite
                                ? height * 0.435
                                : height * 0.295,
                    left: 12,
                    child: Container(
                      height: height * 0.05,
                      width: height * 0.05,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColorLight),
                    )),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 24,
                  right: 30,
                  child: GestureDetector(
                    onTap: () => page.changeTab(),
                    child: Image.asset(
                      'assets/images/back.png',
                      color: Theme.of(context).primaryColor,
                      height: height * 0.06,
                    ),
                  ),
                ),
                Positioned(
                  left: 24,
                  top: height * 0.3,
                  child: InkWell(
                    onTap: () {
                      page.changePage(0);
                      page.changeTab();
                    },
                    child: Text(
                      'Hops',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                Positioned(
                  left: 24,
                  top: height * 0.37,
                  child: InkWell(
                    onTap: () {
                      page.changePage(1);
                      page.changeTab();
                    },
                    child: Text(
                      'Search',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                Positioned(
                  left: 24,
                  top: height * 0.44,
                  child: InkWell(
                    onTap: () {
                      page.changePage(2);
                      page.changeTab();
                    },
                    child: Text(
                      'My stock',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
              ])),
        ]));
  }
}
