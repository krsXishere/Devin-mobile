import 'package:devin/common/theme.dart';
import 'package:devin/pages/qr_scanner_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
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
                const Text(
                  "Buat Akun \nAnda Disini",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: TextFormField(
                    cursorColor: primaryYellow,
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      hintText: "Masukkan nama",
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
                    style: primaryTextStyle.copyWith(
                      fontWeight: regular,
                      fontSize: 15,
                    ),
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
                          MaterialPageRoute(
                              builder: (_) => const QRScannerPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryYellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Daftar",
                      style: primaryTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 20,
                        color: white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
