import 'package:devin/common/dimension.dart';
import 'package:devin/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:devin/common/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  bool isActive = false;
  int _pageIndex = 0;

  storeOnBoardingInfo() async {
    int isViewed = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("onBoarding", isViewed);
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: demo_data.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnBoardingContent(
                    image: demo_data[index].image,
                    title: demo_data[index].title,
                    title2: demo_data[index].title2,
                    title3: demo_data[index].title3,
                    description: demo_data[index].description,
                    textAlign: demo_data[index].textAlign,
                    fontWeight: demo_data[index].fontWeight,
                    fontWeight2: demo_data[index].fontWeight2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    ...List.generate(
                      demo_data.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: DotIndicator(
                          isActive: index == _pageIndex,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2, right: 8, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        decoration: BoxDecoration(
                          color: secondaryYellow,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: (_pageIndex == (demo_data.length - 1))
                            ? SizedBox(
                                height: 59,
                                // width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await storeOnBoardingInfo();
                                    Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                        child: const DashboardPage(),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryYellow,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    "Lanjutkan",
                                    style: primaryTextStyle.copyWith(
                                      fontWeight: bold,
                                      fontSize: 20,
                                      color: white,
                                    ),
                                  ),
                                ),
                              )
                            // Row(
                            //     children: [
                            //       isActive == true
                            //           ? SizedBox(
                            //               height: 60,
                            //               width: 176,
                            //               child: TextButton(
                            //                 onPressed: () {
                            //                   setState(() {
                            //                     isActive = !isActive;
                            //                   });
                            //                   Future.delayed(
                            //                       const Duration(
                            //                           milliseconds: 200), () {
                            //                     Navigator.push(
                            //                       context,
                            //                       PageTransition(
                            //                         child: const RegisterPage(),
                            //                         type: PageTransitionType
                            //                             .rightToLeft,
                            //                       ),
                            //                     );
                            //                   });
                            //                 },
                            //                 child: Text(
                            //                   "Daftar",
                            //                   style: primaryTextStyle.copyWith(
                            //                     fontWeight: bold,
                            //                     fontSize: 20,
                            //                     color: primaryYellow,
                            //                   ),
                            //                 ),
                            //               ),
                            //             )
                            //           : SizedBox(
                            //               height: 60,
                            //               width: 176,
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(8.0),
                            //                 child: ElevatedButton(
                            //                   onPressed: () {
                            //                     Navigator.push(
                            //                       context,
                            //                       PageTransition(
                            //                         child: const RegisterPage(),
                            //                         type: PageTransitionType
                            //                             .rightToLeft,
                            //                       ),
                            //                     );
                            //                   },
                            //                   style: ElevatedButton.styleFrom(
                            //                     backgroundColor: primaryYellow,
                            //                     shape:
                            //                         const RoundedRectangleBorder(
                            //                       borderRadius:
                            //                           BorderRadius.all(
                            //                         Radius.circular(35),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                   child: Text(
                            //                     "Daftar",
                            //                     style:
                            //                         primaryTextStyle.copyWith(
                            //                       fontWeight: bold,
                            //                       fontSize: 20,
                            //                       color: white,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //       isActive == false
                            //           ? SizedBox(
                            //               height: 60,
                            //               width: 176,
                            //               child: TextButton(
                            //                 onPressed: () {
                            //                   setState(() {
                            //                     isActive = !isActive;
                            //                   });
                            //                   Future.delayed(
                            //                       const Duration(
                            //                           milliseconds: 200), () {
                            //                     Navigator.push(
                            //                       context,
                            //                       PageTransition(
                            //                         child: const LoginPage(),
                            //                         type: PageTransitionType
                            //                             .rightToLeft,
                            //                       ),
                            //                     );
                            //                   });
                            //                 },
                            //                 child: Text(
                            //                   "Masuk",
                            //                   style: primaryTextStyle.copyWith(
                            //                     fontWeight: bold,
                            //                     fontSize: 20,
                            //                     color: primaryYellow,
                            //                   ),
                            //                 ),
                            //               ),
                            //             )
                            //           : SizedBox(
                            //               height: 60,
                            //               width: 176,
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(8.0),
                            //                 child: ElevatedButton(
                            //                   onPressed: () {
                            //                     Navigator.push(
                            //                       context,
                            //                       PageTransition(
                            //                         child: const LoginPage(),
                            //                         type: PageTransitionType
                            //                             .rightToLeft,
                            //                       ),
                            //                     );
                            //                   },
                            //                   style: ElevatedButton.styleFrom(
                            //                     backgroundColor: const Color(0XFFFFB423),
                            //                     shape:
                            //                         const RoundedRectangleBorder(
                            //                       borderRadius:
                            //                           BorderRadius.all(
                            //                         Radius.circular(35),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                   child: Text(
                            //                     "Masuk",
                            //                     style:
                            //                         primaryTextStyle.copyWith(
                            //                       fontWeight: bold,
                            //                       fontSize: 20,
                            //                       color: white,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //     ],
                            //   )
                            : IconButton(
                                iconSize: 35,
                                padding: const EdgeInsets.all(12),
                                onPressed: () {
                                  _pageController.nextPage(
                                    curve: Curves.easeInOut,
                                    duration: const Duration(milliseconds: 300),
                                  );
                                },
                                icon: CircleAvatar(
                                  backgroundColor: primaryYellow,
                                  child: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: white,
                                    semanticLabel: "Next",
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: isActive ? 12 : 4,
      decoration: BoxDecoration(
        color: isActive ? primaryYellow : secondaryYellow,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}

class OnBoard {
  final String image, title, title2, title3, description;
  final TextAlign? textAlign;
  final FontWeight? fontWeight, fontWeight2;

  OnBoard({
    required this.image,
    required this.title,
    required this.title2,
    required this.title3,
    required this.description,
    required this.textAlign,
    required this.fontWeight,
    required this.fontWeight2,
  });
}

// ignore: non_constant_identifier_names
final List<OnBoard> demo_data = [
  OnBoard(
    image: 'assets/svg/cuate.svg',
    title: "Devin\nmemudahkan",
    title2: "anda untuk\nmelihat",
    title3: "spesifikasi\nkomputer.",
    description: "",
    textAlign: TextAlign.left,
    fontWeight: bold,
    fontWeight2: medium,
  ),
  OnBoard(
    image: 'assets/svg/pana.svg',
    title: "Jangan ragu\nuntuk memulai,\nayo daftar\nsekarang.",
    title2: "",
    title3: "",
    description:
        "Masuk atau daftar terlebih dahulu\nuntuk melihat spesifikasi komputer anda.",
    textAlign: TextAlign.center,
    fontWeight: bold,
    fontWeight2: semiBold,
  ),
];

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    Key? key,
    required this.image,
    required this.title,
    required this.title2,
    required this.title3,
    required this.description,
    required this.textAlign,
    required this.fontWeight,
    required this.fontWeight2,
  }) : super(key: key);

  final String image, title, title2, title3, description;
  final TextAlign? textAlign;
  final FontWeight? fontWeight, fontWeight2;

  @override
  Widget build(BuildContext context) {
    Dimension(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        Center(
          child: CircleAvatar(
            backgroundColor: secondaryYellow,
            radius: 130,
            child: SvgPicture.asset(image),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        title2 != ""
            ? Text(
                title,
                textAlign: textAlign,
                style: primaryTextStyle.copyWith(
                  fontWeight: fontWeight,
                  fontSize: Dimension.boxHeight! * 4,
                ),
              )
            : Center(
                child: Text(
                  title,
                  textAlign: textAlign,
                  style: primaryTextStyle.copyWith(
                    fontWeight: fontWeight,
                    fontSize: Dimension.boxHeight! * 4,
                  ),
                ),
              ),
        title2 != ""
            ? Text(
                title2,
                textAlign: textAlign,
                style: primaryTextStyle.copyWith(
                  fontWeight: fontWeight2,
                  fontSize: Dimension.boxHeight! * 4,
                ),
              )
            : const SizedBox(),
        title3 != ""
            ? Text(
                title3,
                textAlign: textAlign,
                style: primaryTextStyle.copyWith(
                  fontWeight: fontWeight,
                  fontSize: Dimension.boxHeight! * 4,
                ),
              )
            : const SizedBox(),
        const SizedBox(
          height: 16,
        ),
        Center(
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: primaryTextStyle.copyWith(
              fontSize: Dimension.boxHeight! * 2,
              color: grey,
              fontWeight: light,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
