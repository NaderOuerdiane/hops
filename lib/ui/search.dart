import 'package:flutter/material.dart';
import 'package:hops/components/hop_widget.dart';
import 'package:hops/repository/hops_repository.dart';
import 'package:hops/repository/page_repository.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _search = '';
  FocusNode _searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final page = Provider.of<PageRepository>(context, listen: false);
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final HopsRepository hops = Provider.of<HopsRepository>(context);
    bool alternate = false;
    return SafeArea(
      child: ListView(children: <Widget>[
        Row(
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
            ]),
        Container(
            margin: EdgeInsets.fromLTRB(24, 36, 24, 24),
            child: TextField(
                focusNode: _searchFocusNode,
                onTap: () => page.tab ? page.changeTab() : null,
                decoration: InputDecoration(hintText: 'Search'),
                onChanged: (value) {
                  setState(() {
                    _search = value;
                  });
                },
                style: Theme.of(context).textTheme.headline1)),
        _search.isEmpty
            ? Container(
                margin: EdgeInsets.all(24),
                child: Text('Please fill the search'),
              )
            : Container(
                height: height * 0.54,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ...hops.hops
                        .where((element) =>
                            element.variety.contains(_search) ||
                            element.variety.contains(_search.toUpperCase()))
                        .map((e) {
                      alternate = !alternate;
                      return HopWidget(e, hops, alternate);
                    }).toList()
                  ],
                ),
              ),
      ]),
    );
  }
}
