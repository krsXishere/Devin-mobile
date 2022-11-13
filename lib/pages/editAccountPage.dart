import 'package:devin/common/theme.dart';
import 'package:flutter/material.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({Key? key}) : super(key: key);

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
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
        title: Text("Edit Akun",
            style: primaryTextStyle.copyWith(
              fontWeight: bold,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: primaryYellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Simpan",
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: regular,
                ),
              ),
            ),
          )
        ],
        centerTitle: true,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ubah Foto",
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: regular,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/png/profil.png"),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: primaryYellow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama",
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: regular,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
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
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: regular,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password",
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: regular,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
