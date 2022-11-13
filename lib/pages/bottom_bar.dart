import 'package:devin/common/theme.dart';
import 'package:devin/pages/accountPage.dart';
import 'package:devin/pages/qr_scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    QRScannerPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  iconColor: Colors.black,
                  iconActiveColor: Colors.white,
                  text: 'Beranda',
                  textStyle: primaryTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  textColor: Colors.white,
                  backgroundColor: primaryYellow,
                ),
                GButton(
                  icon: LineIcons.laptop,
                  iconColor: Colors.black,
                  iconActiveColor: Colors.white,
                  text: 'Pindai',
                  textStyle: primaryTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  backgroundColor: primaryYellow,
                ),
                GButton(
                  icon: LineIcons.user,
                  iconColor: Colors.black,
                  iconActiveColor: Colors.white,
                  text: 'Akun',
                  textStyle: primaryTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  textColor: Colors.white,
                  backgroundColor: primaryYellow,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
