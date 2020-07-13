import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SpinKitRing(
        color: Theme.of(context).primaryColor,
        size: 30,
        lineWidth: 3,
      ),
    );
  }
}
