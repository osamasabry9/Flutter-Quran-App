import 'package:flutter/material.dart';

import '../utils/app_constant.dart';

class BasmalaWidget extends StatelessWidget {
  const BasmalaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: Text(
          "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
          style: TextStyle(
              fontFamily: 'quran', fontSize: AppConstant.arabicFontSize),
          textDirection: TextDirection.rtl,
        ),
      ),
    ]);
  }
}