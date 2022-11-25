import 'package:devin/common/theme.dart';
import 'package:devin/pages/qr_scanner_page.dart';
import 'package:devin/providers/spesification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'bottom_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpesificationPage extends ConsumerStatefulWidget {
  //final String? pcName, os, processor, ram, vgaCard, storage, lab;
  final String id;
  //final int? table;

  const SpesificationPage({
    Key? key,
    // required this.pcName,
    // required this.os,
    // required this.processor,
    // required this.ram,
    // required this.vgaCard,
    // required this.storage,
    // required this.lab,
    // required this.table,
    required this.id,
  }) : super(key: key);

  @override
  ConsumerState<SpesificationPage> createState() => _SpesificationPageState();
}

class _SpesificationPageState extends ConsumerState<SpesificationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Spesifikasi Komputer",
          style: primaryTextStyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: BottomBar(),
                type: PageTransitionType.leftToRight,
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          color: black,
        ),
      ),
      body: SafeArea(
        child: ref
            .watch(
              spesificationProvider(widget.id),
            )
            .when(
              data: (data) => Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height - 400,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                            color: const Color(0XFFFFB423).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height - 300,
                          width: MediaQuery.of(context).size.width - 70,
                          decoration: BoxDecoration(
                            color: const Color(0XFFFFB423),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${data!.pcName}",
                                    style: primaryTextStyle.copyWith(
                                      color: white,
                                      fontWeight: bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                indent: 45,
                                endIndent: 45,
                                thickness: 3,
                                color: white,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "OS Komputer: ",
                                    style: primaryTextStyle.copyWith(
                                      color: white,
                                      fontWeight: bold,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Text(
                                      "${data.os}",
                                      style: primaryTextStyle.copyWith(
                                        color: white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Processor:  ",
                                    style: primaryTextStyle.copyWith(
                                      color: white,
                                      fontWeight: bold,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${data.processor}",
                                      style: primaryTextStyle.copyWith(
                                        color: white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "RAM: ",
                                    style: primaryTextStyle.copyWith(
                                      color: white,
                                      fontWeight: bold,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${data.ram}",
                                      style: primaryTextStyle.copyWith(
                                        color: white,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kartu Grafik: ",
                                    style: primaryTextStyle.copyWith(
                                      color: white,
                                      fontWeight: bold,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${data.vgaCard}",
                                      style: primaryTextStyle.copyWith(
                                        color: white,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Penyimpanan: ",
                                    style: primaryTextStyle.copyWith(
                                      color: white,
                                      fontWeight: bold,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${data.storage}",
                                      style: primaryTextStyle.copyWith(
                                        color: white,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ruangan LAB Komputer: ",
                                    style: primaryTextStyle.copyWith(
                                      color: white,
                                      fontWeight: bold,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${data.lab}",
                                      style: primaryTextStyle.copyWith(
                                        color: white,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Nomor Meja: ",
                                    style: primaryTextStyle.copyWith(
                                      color: white,
                                      fontWeight: bold,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${data.table}",
                                      style: primaryTextStyle.copyWith(
                                        color: white,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              error: ((error, stackTrace) => AlertDialog(
                    title: const Text("Peringatan"),
                    content: Text("Error: $error"),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const QRScannerPage(),
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
                          "Lihat Spesifikasi",
                          style: primaryTextStyle.copyWith(
                            color: white,
                            fontWeight: bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  )),
              loading: () => Center(
                child: CircularProgressIndicator(
                  color: primaryYellow,
                  strokeWidth: 3.0,
                ),
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
