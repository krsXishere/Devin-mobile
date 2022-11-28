import 'dart:developer';

import 'package:devin/common/theme.dart';
import 'package:devin/pages/spesification_page.dart';
import 'package:flutter/material.dart';
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
  final GlobalKey _globalKey = GlobalKey(debugLabel: 'QR');
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

    Future.delayed(const Duration(seconds: 2), () {
      if (spesificationModel?.code == 200) {
        setState(() {
          isLoading = false;
        });

        Navigator.push(
          context,
          PageTransition(
            child: SpesificationPage(
              id: id.toString(),
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

  Future<void> navigate() async {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isLoading = false;
      });
      log("ID: " + id.toString());

      Navigator.push(
        context,
        PageTransition(
          child: SpesificationPage(
            id: id.toString(),
          ),
          type: PageTransitionType.rightToLeft,
        ),
      );
    });
  }

  void qr(QRViewController controller) {
    setState(() {
      qrViewController = controller;
    });

    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });

      if (result != null) {
        trimResultQRCode();
      }
    });

    qrViewController?.pauseCamera();
    qrViewController?.resumeCamera();
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
    qrViewController?.pauseCamera();
    qrViewController?.dispose();
  }

  @override
  void initState() {
    super.initState();
    getCameraPermission();
    // spesificationModel;
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                child: Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                        ),
                        color: white,
                      ),
                      const Spacer(),
                      SizedBox(
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
                      )
                    ],
                  ),
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
                                navigate();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryYellow,
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
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryYellow,
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
