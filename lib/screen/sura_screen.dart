import 'package:flutter/material.dart';
import '../core/utils/app_constant.dart';
import '../app/app_pref.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SuraScreen extends StatefulWidget {
  final int sura;
  final List arabic;
  final String suraName;
  int ayah;

  SuraScreen(
      {Key? key,
      required this.sura,
      required this.arabic,
      required this.suraName,
      required this.ayah})
      : super(key: key);

  @override
  State<SuraScreen> createState() => _SuraScreenState();
}

class _SuraScreenState extends State<SuraScreen> {
  bool view = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => jumbToAyah());
    super.initState();
  }

  jumbToAyah() {
    if (AppConstant.fabIsClicked) {
      AppConstant.itemScrollController.scrollTo(
          index: widget.ayah,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    }
    AppConstant.fabIsClicked = false;
  }

  Row verseBuilder(int index, int previousVerses) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.arabic[index + previousVerses]['aya_text'],
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: AppConstant.arabicFontSize,
                  fontFamily: AppConstant.arabicFont,
                  color: const Color.fromARGB(196, 0, 0, 0),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [],
              ),
            ],
          ),
        ),
      ],
    );
  }

  SafeArea singleSuraBuilder(lenghtOfSura) {
    String fullSura = '';
    int previousVerses = 0;
    if (widget.sura + 1 != 1) {
      for (int i = widget.sura - 1; i >= 0; i--) {
        previousVerses = previousVerses + AppConstant.noOfVerses[i];
      }
    }

    if (!view) {
      for (int i = 0; i < lenghtOfSura; i++) {
        fullSura += (widget.arabic[i + previousVerses]['aya_text']);
      }
    }

    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 253, 251, 240),
        child: view
            ? ScrollablePositionedList.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      (index != 0) || (widget.sura == 0) || (widget.sura == 8)
                          ? const Text('')
                          : const RetunBasmala(),
                      Container(
                        color: index % 2 != 0
                            ? const Color.fromARGB(255, 253, 251, 240)
                            : const Color.fromARGB(255, 253, 247, 230),
                        child: PopupMenuButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: verseBuilder(index, previousVerses),
                            ),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () {
                                      AppPreferences.saveBookMark(
                                          widget.sura + 1, index);
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.bookmark_add,
                                          color:
                                              Color.fromARGB(255, 56, 115, 59),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('Bookmark'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {},
                                    child: Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: const [
                                        Icon(
                                          Icons.share,
                                          color:
                                              Color.fromARGB(255, 56, 115, 59),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('Share'),
                                      ],
                                    ),
                                  ),
                                ]),
                      ),
                    ],
                  );
                },
                itemScrollController: AppConstant.itemScrollController,
                itemPositionsListener: AppConstant.itemPositionsListener,
                itemCount: lenghtOfSura,
              )
            : ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.sura + 1 != 1 && widget.sura + 1 != 9
                                ? const RetunBasmala()
                                : const Text(''),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                fullSura, //mushaf mode
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: AppConstant.mushafFontSize,
                                  fontFamily: AppConstant.arabicFont,
                                  color: const Color.fromARGB(196, 44, 44, 44),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int lengthOfSura = AppConstant.noOfVerses[widget.sura];

    return Scaffold(
      appBar: AppBar(
        leading: Tooltip(
          message: 'Mushaf Mode',
          child: TextButton(
            child: const Icon(
              Icons.chrome_reader_mode,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                view = !view;
              });
            },
          ),
        ),
        centerTitle: true,
        title: Text(
          // widget.
          widget.suraName,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'quran',
              shadows: [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 2.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ]),
        ),
        backgroundColor: const Color.fromARGB(255, 56, 115, 59),
      ),
      body: singleSuraBuilder(lengthOfSura),
    );
  }
}

class RetunBasmala extends StatelessWidget {
  const RetunBasmala({Key? key}) : super(key: key);

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
