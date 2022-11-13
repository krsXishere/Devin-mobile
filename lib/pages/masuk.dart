import 'package:devin/pages/bottom_bar.dart';
import 'package:devin/pages/qr_scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../common/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hai, \nSelamat Datang Kembali",
                  style: primaryTextStyle.copyWith(
                    fontSize: 48,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: primaryYellow,
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      hintText: "Masukkan email",
                      hintStyle: primaryTextStyle.copyWith(
                        fontWeight: regular,
                        fontSize: 15,
                        color: grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: TextFormField(
                    obscureText: isVisible,
                    cursorColor: primaryYellow,
                    controller: passwordController,
                    decoration: InputDecoration(
                      suffixIcon: isVisible == false
                          ? IconButton(
                              icon: Icon(
                                Icons.visibility,
                                color: primaryYellow,
                              ),
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.visibility_off,
                                color: grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                            ),
                      filled: true,
                      border: InputBorder.none,
                      hintText: "Masukkan password",
                      hintStyle: primaryTextStyle.copyWith(
                        fontWeight: regular,
                        fontSize: 15,
                        color: grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: BottomBar(),
                          // child: const QRScannerPage(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryYellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Masuk",
                      style: primaryTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 20,
                        color: white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
