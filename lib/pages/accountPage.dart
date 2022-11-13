import 'package:devin/common/theme.dart';
import 'package:devin/pages/editAccountPage.dart';
import 'package:flutter/material.dart';
import './accordion.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Akun",
          style: primaryTextStyle.copyWith(
            fontSize: 20,
            fontWeight: bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Center(
              child: Stack(
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
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: primaryYellow,
                ),
                height: 125,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Akun Pengguna",
                        style: primaryTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Salsa Amelia",
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: regular,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "salsaamelia@gmail.com",
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: regular,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfil(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/png/Edit.png",
                      height: 23,
                      width: 23,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Ubah Profile",
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: regular,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Accordion(
              title: "Tentang Aplikasi",
              content:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam bibendum ornare vulputate. Curabitur faucibus condimentum purus quis tristique.",
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 22.0, bottom: 20.0, top: 15.0),
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Image.asset(
                      "assets/png/devin.png",
                      height: 18,
                      width: 18,
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
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, bottom: 10.0, top: 10.0),
              child: InkWell(
                onTap: () {
                  AlertDialog alert = AlertDialog(
                    title: Text("Konfirmasi",
                        textAlign: TextAlign.center,
                        style: primaryTextStyle.copyWith(
                          color: Colors.black,
                          fontWeight: bold,
                        )),
                    content: Text(
                        "Apakah kamu yakin akan keluar dari aplikasi Devin ?",
                        textAlign: TextAlign.center,
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                          color: const Color(0xFF767676),
                        )),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            child: Text(
                              "Batal",
                              style: primaryTextStyle.copyWith(
                                  color: primaryYellow),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                width: 2.0,
                                color: primaryYellow,
                              ),
                              shape: const StadiumBorder(),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: primaryYellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              "Ok",
                              style: primaryTextStyle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: primaryYellow,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Keluar",
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: regular,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
