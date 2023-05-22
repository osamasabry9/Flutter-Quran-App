import 'package:flutter/material.dart';

import '../../screen/sura_screen.dart';
import '../utils/app_constant.dart';
import '../utils/arabic_sura_number.dart';

class NameAndNumSuraWidget extends StatelessWidget {
  const NameAndNumSuraWidget({
    super.key,
    required this.quran,
  });

  final List quran;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 221, 250, 236),
      child: ListView(
        children: [
          for (int i = 0; i < 114; i++)
            Container(
              color: i % 2 == 0
                  ? const Color.fromARGB(255, 253, 247, 230)
                  : const Color.fromARGB(255, 253, 251, 240),
              child: TextButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      ArabicSuraNumber(i: i),
                      const Expanded(child: SizedBox()),
                      Text(
                        AppConstant.arabicName[i]['name'],
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.black87,
                            fontFamily: 'quran',
                            shadows: [
                              Shadow(
                                offset: Offset(.5, .5),
                                blurRadius: 1.0,
                                color: Color.fromARGB(255, 130, 130, 130),
                              )
                            ]),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  AppConstant.fabIsClicked = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SuraScreen(
                              arabic: quran[0],
                              sura: i,
                              suraName: AppConstant.arabicName[i]['name'],
                              ayah: 0,
                            )),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
