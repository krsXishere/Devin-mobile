import 'dart:io';

import 'package:devin/common/theme.dart';
import 'package:devin/pages/spesification_page.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/spesification_model.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey _globalKey = GlobalKey();
  QRViewController? qrViewController;
  Barcode? result;
  SpesificationModel? spesificationModel;
  String? id;
  bool isLoading = false;
  bool flashOn = false;
  bool cameraFront = false;

  Future<void> getData() async {
    SpesificationModel.sendRequest(id).then((value) {
      setState(() {
        spesificationModel = value;
      });
    });

    setState(() {
      isLoading = true;
    });

    print("Heeh " + id.toString());

    Future.delayed(const Duration(seconds: 2), () {
      if (spesificationModel?.code == "200") {
        setState(() {
          isLoading = false;
        });
        Navigator.push(
          context,
          PageTransition(
            child: SpesificationPage(
              pcName: spesificationModel?.pcName,
              os: spesificationModel?.os,
              processor: spesificationModel?.processor,
              ram: spesificationModel?.ram,
              vgaCard: spesificationModel?.vgaCard,
              storage: spesificationModel?.storage,
              lab: spesificationModel?.lab,
              table: spesificationModel?.table,
            ),
            type: PageTransitionType.rightToLeft,
          ),
        );
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void qr(QRViewController controller) {
    qrViewController = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });

      if (result != null) {
        trimResultQRCode();
      }
    });
  }

  Future<PermissionStatus> getCameraPermission() async {
    var status = await Permission.camera.status;

    if (status.isDenied) {
      final result = await Permission.camera.request();
      return result;
    } else {
      return status;
    }
  }

  String trimResultQRCode() {
    String code = result!.code.toString();
    String codeSubbed = code.substring(code.lastIndexOf("/"));
    String codeSubbed2 = codeSubbed.substring(1);
    id = codeSubbed2;
    return codeSubbed2;
  }

  @override
  void dispose() {
    super.dispose();
    qrViewController?.stopCamera();
  }

  @override
  void initState() {
    super.initState();
    getCameraPermission();
    spesificationModel;
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400) ||
            (MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.bottomCenter,
            fit: StackFit.loose,
            children: [
              QRView(
                key: _globalKey,
                onQRViewCreated: qr,
                overlay: QrScannerOverlayShape(
                  borderColor: primaryYellow,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: scanArea,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Row(
                  children: [
                    IconButton(
                      color: white,
                      onPressed: () {
                        setState(() {
                          qrViewController!.flipCamera();
                          cameraFront = !cameraFront;
                        });
                      },
                      icon: Icon(
                        cameraFront == false
                            ? Icons.camera_front_rounded
                            : Icons.camera_rear_rounded,
                      ),
                    ),
                    IconButton(
                      color: white,
                      onPressed: () {
                        setState(() {
                          qrViewController!.toggleFlash();
                          flashOn = !flashOn;
                        });
                      },
                      icon: Icon(
                        flashOn == false
                            ? Icons.flash_off_rounded
                            : Icons.flash_on_rounded,
                      ),
                    ),
                  ],
                ),
              ),
              result != null
                  ? const SizedBox()
                  : Positioned(
                      top: 120,
                      child: Text(
                        "Pindai",
                        style: primaryTextStyle.copyWith(
                            color: primaryYellow,
                            fontWeight: bold,
                            fontSize: 50),
                      ),
                    ),
              result != null
                  ? isLoading == false
                      ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                getData();
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
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                getData();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: primaryYellow,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                                color: white,
                              ),
                            ),
                          ),
                        )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
