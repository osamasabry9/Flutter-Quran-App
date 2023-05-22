import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/app_constant.dart';
import '../screen/sura_screen.dart';

class AppPreferences {
  static Future saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('arabicFontSize', AppConstant.arabicFontSize.toInt());
    await prefs.setInt('mushafFontSize', AppConstant.mushafFontSize.toInt());
  }

  static Future getSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      AppConstant.arabicFontSize = prefs.getInt('arabicFontSize')!.toDouble();
      AppConstant.mushafFontSize = prefs.getInt('mushafFontSize')!.toDouble();
    } catch (_) {
      AppConstant.arabicFontSize = 28;
      AppConstant.mushafFontSize = 40;
    }
  }

  static saveBookMark(surah, ayah) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("surah", surah);
    await prefs.setInt("ayah", ayah);
  }

  static Future<void> readBookmark(BuildContext context) async {
    debugPrint("read book mark called");
    final prefs = await SharedPreferences.getInstance();
    try {
      AppConstant.bookmarkedAyah = prefs.getInt('ayah')!;
      AppConstant.bookmarkedSura = prefs.getInt('surah')!;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SuraScreen(
                    arabic: AppConstant.quran[0],
                    sura: AppConstant.bookmarkedSura - 1,
                    suraName: AppConstant
                        .arabicName[AppConstant.bookmarkedSura - 1]['name'],
                    ayah: AppConstant.bookmarkedAyah,
                  )));
    } catch (e) {
      debugPrint("read book mark catch");
    }
  }
}
