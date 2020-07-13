import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hops/models/hop_model.dart';
import 'package:hops/repository/hops_repository.dart';
import 'package:hops/repository/page_repository.dart';
import 'package:hops/ui/details.dart';
import 'package:provider/provider.dart';

class HopWidget extends StatelessWidget {
  final Hop hop;
  final HopsRepository hops;
  final bool alternate;
  HopWidget(this.hop, this.hops, this.alternate);

  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider.value(
                    value: hops, child: DetailsPage(hop))));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: alternate ? Color(0xFF4f858a) : Color(0xFFbdd6be),
        ),
        margin: EdgeInsets.fromLTRB(24, 12, 0, 12),
        width: width * 0.48,
        child: Stack(
          children: <Widget>[
            Positioned(
              width: width * 0.44,
              height: width * 0.44,
              top: width * 0.02,
              left: width * 0.02,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [
                              alternate ? Color(0xFF6ba496) : Color(0xFFcae5ca),
                              alternate ? Color(0xFF3f7d74) : Color(0xFF95b89e),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Hero(
                      tag: hop.variety,
                      child: Stack(children: [
                        Opacity(
                            child: ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaX: 12.5, sigmaY: 12.5),
                              child: Image.asset('assets/images/hop2.png',
                                  color: Colors.black),
                            ),
                            opacity: 1),
                        Image.asset('assets/images/hop2.png'),
                      ]),
                    )),
              ),
            ),
            Positioned(
              top: width * 0.44 * 0.75,
              left: width * 0.44 * 0.05,
              child: GestureDetector(
                  onTap: () async {
                    await hops.compare(hop.variety);
                    print(hops.cmps.length);
                  },
                  child: !hops.cmps.contains(hop.variety)
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: alternate
                                ? Color(0xFF4f858a)
                                : Color(0xFFbdd6be),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/images/compare-icon.png',
                                width: width * 0.44 * 0.2,
                              )),
                        )
                      : Stack(
                          children: <Widget>[
                            Positioned(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: alternate
                                      ? Color(0xFF4f858a)
                                      : Color(0xFFbdd6be),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset(
                                      'assets/images/compare-icon.png',
                                      width: width * 0.44 * 0.2,
                                    )),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: width * 0.44 * 0.2 * 0.7,
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(
                                    hops.cmps.indexOf(hop.variety) == 0
                                        ? 5
                                        : 2),
                                child: Text(
                                  hops.cmps.indexOf(hop.variety) == 0
                                      ? '*'
                                      : '${hops.cmps.indexOf(hop.variety)}',
                                  style: TextStyle(
                                      color: hops.cmps.indexOf(hop.variety) == 0
                                          ? Theme.of(context).cursorColor
                                          : Theme.of(context).primaryColor,
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        )),
            ),
            Positioned(
              left: width * 0.02,
              top: width * 0.02 + width * 0.44 + width * 0.04,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      hop.variety,
                      style: TextStyle(
                        fontSize: width * 0.038,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text('Alpha Acids: ${hop.alpha_min}% - ${hop.alpha_max}%',
                        style: TextStyle(
                            fontSize: width * 0.032,
                            color: alternate
                                ? Color(0xFFbdd6be)
                                : Color(0xFF4f858a),
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    Text('Beta Acids: ${hop.beta_min}% - ${hop.beta_max}%',
                        style: TextStyle(
                            fontSize: width * 0.032,
                            color: alternate
                                ? Color(0xFFbdd6be)
                                : Color(0xFF4f858a),
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: width * 0.032,
                                color: alternate
                                    ? Color(0xFFbdd6be)
                                    : Color(0xFF4f858a),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Comfortaa'),
                            children: <TextSpan>[
                          TextSpan(text: 'Total oil'),
                          TextSpan(
                              text: ' (mL/100g)',
                              style: TextStyle(
                                  fontSize: width * 0.02,
                                  color: alternate
                                      ? Color(0xFFbdd6be)
                                      : Color(0xFF4f858a),
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  ': ${hop.total_oil_min}% - ${hop.total_oil_max}%')
                        ])),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
