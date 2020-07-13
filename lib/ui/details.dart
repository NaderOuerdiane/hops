import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hops/components/hop_substitute.dart';
import 'package:hops/components/loading_widget.dart';
import 'package:hops/models/hop_model.dart';
import 'package:hops/repository/hops_repository.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  Hop hop;
  DetailsPage(this.hop);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final double width = MediaQuery.of(context).size.width;
    final hops = Provider.of<HopsRepository>(context);
    bool alternate = false;

    final List<String> list = getSubstituteFromList(widget.hop);
    return SafeArea(
      child: Scaffold(
        body: ListView(controller: _scrollController, children: <Widget>[
          SizedBox(
            height: height * 0.9,
            child: Stack(children: <Widget>[
              Positioned(
                height: height * 0.1,
                width: width,
                top: 0,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          margin: EdgeInsets.only(left: 24, top: 24),
                          child: Image.asset('assets/images/back2.png',
                              height: height * 0.1),
                        ),
                      ),
                      FutureBuilder(
                        future: hops.updateFavorite(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState != ConnectionState.done)
                            return Container(
                                margin: EdgeInsets.only(right: 24, top: 24),
                                child: LoadingElement());
                          else
                            return GestureDetector(
                              onTap: () async {
                                await hops.favorite(widget.hop.variety);
                                print(hops.favs.length);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 24, top: 24),
                                child: snapshot.data
                                        .contains(widget.hop.variety)
                                    ? Image.asset(
                                        'assets/images/heart_filled.png',
                                        color: Theme.of(context).primaryColor,
                                        height: height * 0.1,
                                      )
                                    : Image.asset(
                                        'assets/images/heart.png',
                                        color: Theme.of(context).primaryColor,
                                        height: height * 0.1,
                                      ),
                              ),
                            );
                        },
                      ),
                    ]),
              ),
              Positioned(
                  top: height * 0.175,
                  height: height * 0.5,
                  width: height * 0.5,
                  left: width * 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFeaf2eb),
                              Color(0xFFa9bbb5),
                            ])),
                  )),
              Positioned(
                top: height * 0.15,
                height: height * 0.55,
                width: height * 0.55,
                left: width * 0.4 - height * 0.025,
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
                      child: Hero(
                        tag: widget.hop.variety,
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
                        ]),
                      )),
                ),
              ),
              Positioned(
                top: height * 0.2,
                left: 24,
                width: width * 0.6,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.hop.variety,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                          'Alpha Acids: ${widget.hop.alpha_min}% - ${widget.hop.alpha_max}%',
                          style: Theme.of(context).textTheme.headline3),
                    ]),
              ),
              Positioned(
                  top: height * 0.4,
                  left: 24,
                  width: width * 0.8,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: width * 0.6,
                          child: Text(
                            widget.hop.flavor_description ?? '',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                        Text(
                            'Beta Acids: ${widget.hop.beta_min}% - ${widget.hop.beta_max}%',
                            style: Theme.of(context).textTheme.headline3),
                        SizedBox(height: height * 0.005),
                        RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.headline3,
                                children: <TextSpan>[
                              TextSpan(text: 'Total oil'),
                              TextSpan(
                                  text: ' (mL/100g)',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2ce8d46))),
                              TextSpan(
                                  text:
                                      ': ${widget.hop.total_oil_min}% - ${widget.hop.total_oil_max}%')
                            ])),
                      ])),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(left: 24),
            child: Text(
              'Substitutes',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Container(
            height: height * 0.54,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                ...hops.hops
                    .where((element) => list.contains(element.variety))
                    .map((e) {
                  alternate = !alternate;
                  return HopSubstituteWidget(e, hops, alternate);
                }).toList()
              ],
            ),
          ),
        ]),
      ),
    );
  }

  List<String> getSubstituteFromList(Hop hop) {
    try {
      String full = hop.substitutes;
      List<String> list = [];
      int comma;
      comma = full.indexOf(',');
      list.add(full.substring(0, comma).toUpperCase());
      full = full.substring(comma + 1);
      while (full.isNotEmpty) {
        comma = full.indexOf('"');
        full = full.substring(comma + 1);
        comma = full.indexOf('"');
        if (comma == -1) {
          list.add(full.toUpperCase());
          break;
        } else {
          list.add(full.substring(0, comma).toUpperCase());
          full = full.substring(comma + 3);
        }
      }
      return list;
    } catch (err) {
      return [];
    }
  }
}
