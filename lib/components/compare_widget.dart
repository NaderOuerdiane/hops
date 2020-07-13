import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hops/models/hop_model.dart';

class CompareWidget extends StatelessWidget {
  final Hop mainHop;
  final Hop currentHop;
  final bool alternate;
  final ScrollController scrollController;
  final int number;
  final double height;
  CompareWidget(this.mainHop, this.currentHop, this.alternate,
      this.scrollController, this.number, this.height);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    TextStyle stylee = TextStyle(
        fontSize: 14,
        color: alternate ? Color(0xFFcae5ca) : Color(0xFF6ba496),
        fontWeight: FontWeight.w600);

    TextStyle stylee2 = TextStyle(
        fontSize: 12,
        color: alternate ? Color(0xFFcae5ca) : Color(0xFF6ba496),
        fontWeight: FontWeight.w600);

    return Container(
      margin: EdgeInsets.only(left: 12),
      width: width * 0.4,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 64,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100)),
                color: alternate ? Color(0xFF4f858a) : Color(0xFFbdd6be),
              ),
              width: width * 0.4,
              height: height * 0.7,
            ),
          ),
          Positioned(
            width: width * 0.36,
            height: width * 0.36,
            top: width * 0.02 + 64,
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
          Positioned(
            child: Text(
              currentHop.variety,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Positioned(
            top: width * 0.36 + 32 - 12,
            left: width * 0.36 * 0.1,
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                number.toString(),
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            top: height * 0.325,
            left: 0.0,
            right: 0.0,
            bottom: 0,
            child: ListView(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.alpha_min.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.alpha_min > mainHop.alpha_min
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.alpha_min - mainHop.alpha_min)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.alpha_max.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.alpha_max > mainHop.alpha_max
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.alpha_max - mainHop.alpha_max)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.beta_min.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.beta_min > mainHop.beta_min
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.beta_min - mainHop.beta_min)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.beta_max.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.beta_max > mainHop.beta_max
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.beta_max - mainHop.beta_max)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.total_oil_min.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.total_oil_min > mainHop.total_oil_min
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.total_oil_min - mainHop.total_oil_min)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.total_oil_max.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.total_oil_max > mainHop.total_oil_max
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.total_oil_max - mainHop.total_oil_max)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.cohumulone_min.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.cohumulone_min > mainHop.cohumulone_min
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.cohumulone_min - mainHop.cohumulone_min)
                            .abs()
                            .round()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.cohumulone_max.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.cohumulone_max > mainHop.cohumulone_max
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.cohumulone_max - mainHop.cohumulone_max)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.b_pinene_min.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.b_pinene_min > mainHop.b_pinene_min
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.b_pinene_min - mainHop.b_pinene_min)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.b_pinene_max.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.b_pinene_max > mainHop.b_pinene_max
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.b_pinene_max - mainHop.b_pinene_max)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.myrcene_min.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.myrcene_min > mainHop.myrcene_min
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.myrcene_min - mainHop.myrcene_min)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.myrcene_max.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.myrcene_max > mainHop.myrcene_max
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.myrcene_max - mainHop.myrcene_max)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.linalool_min.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.linalool_min > mainHop.linalool_min
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.linalool_min - mainHop.linalool_min)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.linalool_max.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.linalool_max > mainHop.linalool_max
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.linalool_max - mainHop.linalool_max)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.caryphyllene_min.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.caryphyllene_min > mainHop.caryphyllene_min
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.caryphyllene_min - mainHop.caryphyllene_min)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.caryphyllene_max.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.caryphyllene_max > mainHop.caryphyllene_max
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.caryphyllene_max - mainHop.caryphyllene_max)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.farnesene_min.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.farnesene_min > mainHop.farnesene_min
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.farnesene_min - mainHop.farnesene_min)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.farnesene_max.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.farnesene_max > mainHop.farnesene_max
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.farnesene_max - mainHop.farnesene_max)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.humulene_min.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.humulene_min > mainHop.humulene_min
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.humulene_min - mainHop.humulene_min)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.humulene_max.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.humulene_max > mainHop.humulene_max
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.humulene_max - mainHop.humulene_max)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.geraniol_min.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.geraniol_min > mainHop.geraniol_min
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.geraniol_min - mainHop.geraniol_min)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.geraniol_max.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.geraniol_max > mainHop.geraniol_max
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.geraniol_max - mainHop.geraniol_max)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.selinene_min.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.selinene_min > mainHop.selinene_min
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.selinene_min - mainHop.selinene_min)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.selinene_max.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.selinene_max > mainHop.selinene_max
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.selinene_max - mainHop.selinene_max)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.other_min.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.other_min > mainHop.other_min
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.other_min - mainHop.other_min)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        currentHop.other_max.toString(),
                        style: stylee,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Image.asset(
                        currentHop.other_max > mainHop.other_max
                            ? 'assets/images/arrow-up.png'
                            : 'assets/images/arrow-down.png',
                        height: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4 * 0.33,
                      child: Text(
                        (currentHop.other_max - mainHop.other_max)
                            .abs()
                            .toStringAsFixed(1),
                        style: stylee2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
              ],
            ),
          )
        ],
      ),
    );
  }
}
