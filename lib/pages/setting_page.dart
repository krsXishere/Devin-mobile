import 'package:devin/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import 'accordion.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          color: black,
        ),
        centerTitle: true,
        backgroundColor: white,
        elevation: 0,
        title: Text(
          "Pengaturan",
          style: primaryTextStyle.copyWith(
            fontWeight: bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Accordion(
                title: "Tentang Aplikasi",
                content:
                    "Devin adalah sebuah aplikasi yang dirancang khusus untuk anda, dengan Devin anda dapat mengelola lab komputer dengan lebih mudah.",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  title: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/devin-setting.svg",
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Versi Aplikasi",
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    "V 1.0.0 (Beta)",
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: regular,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Icon(
                      isActive == false ? LineIcons.sun : LineIcons.moon,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Mode Gelap",
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: regular,
                      ),
                    ),
                    const Spacer(),
                    Switch(
                      inactiveThumbColor: primaryYellow,
                      activeColor: blue,
                      // inactiveThumbImage: AssetImage(""),
                      value: isActive,
                      onChanged: (bool onChanged) {
                        setState(() {
                          isActive = onChanged;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: 100,
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/svg/devin_logo.svg",
              color: black,
              width: 107,
              height: 40,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "© 2022. All Right Reserved by",
                  style: primaryTextStyle,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "CAAOCI",
                  style: primaryTextStyle.copyWith(
                    color: primaryYellow,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
