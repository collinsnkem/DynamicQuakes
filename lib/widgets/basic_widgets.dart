import 'package:earthquake_app/utils/colors.dart';
import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
            text: 'Dynamic',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: secDark,
                fontFamily: 'Jost')),
        TextSpan(
            text: 'Quakes',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: pryColor,
                fontSize: 22,
                fontFamily: 'Jost')),
      ],
    ),
  );
}
