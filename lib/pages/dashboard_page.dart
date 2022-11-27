// ignore_for_file: unused_result

import 'dart:async';
import 'dart:developer';
import 'package:devin/common/theme.dart';
import 'package:devin/models/weather_model.dart';
import 'package:devin/pages/qr_scanner_page.dart';
import 'package:devin/pages/setting_page.dart';
import 'package:devin/providers/count_pc_provider.dart';
import 'package:devin/services/location_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:intl/intl.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  LocationService locationService = LocationService();
  String addres = "";
  String addresLocality = "";
  double? latitude = 0;
  double? longitude = 0;
  String formattedTime = DateFormat('HH:mm').format(DateTime.now());
  String formattedDay = DateFormat('d MMM yyyy').format(DateTime.now());
  Timer? timer;
  WeatherModel? weatherModel;
  bool isLoading = false;
  String? weather;
  int? weatherStatus;
  CancelToken? cancelToken;

  @override
  void dispose() {
    super.dispose();
    locationService.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    getCurrentDateAndTime();
    getLocationPermission();

    locationService.locationStream.listen((location) {
      setState(() {
        latitude = location.latitude;
        longitude = location.longitude;
      });
    });

    getIsLoading();

    log("LatLong: " + latitude.toString() + " " + longitude.toString());
    log("Lokasi: " + addresLocality);
    // getWeather();
    // convertWeather();
  }

  Future<void> getWeather() async {
    Future.delayed(const Duration(seconds: 2), () {
      WeatherModel.sendRequest(addresLocality).then((value) {
        setState(() {
          weatherModel = value;
        });
      });
    });
  }

  Future<void> getIsLoading() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
        getLocation();
        getLocationLocality();

        if (addresLocality != "") {
          getWeather();
          weatherModel;
          convertWeather();
        } else {
          setState(() {
            isLoading = true;
          });
          getIsLoading();
          setState(() {
            isLoading = false;
          });
        }
      });
    });
  }

  getCurrentDateAndTime() {
    // var format = DateFormat.("");
    if (mounted) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          formattedTime = DateFormat('HH:mm').format(DateTime.now());
          formattedDay = DateFormat('EE').format(DateTime.now());

          if (formattedDay == "Sun") {
            setState(() {
              formattedDay = "Sen";
            });
          } else if (formattedDay == "Tu" ||
              formattedDay == "Tue" ||
              formattedDay == "Tues") {
            setState(() {
              formattedDay = "Sel";
            });
          } else if (formattedDay == "Wed") {
            setState(() {
              formattedDay = "Rab";
            });
          } else if (formattedDay == "Th" ||
              formattedDay == "Thu" ||
              formattedDay == "Thur" ||
              formattedDay == "Thurs") {
            setState(() {
              formattedDay = "Kam";
            });
          } else if (formattedDay == "Fri") {
            setState(() {
              formattedDay == "Jum";
            });
          } else if (formattedDay == "Sat") {
            setState(() {
              formattedDay = "Sab";
            });
          } else {
            setState(() {
              formattedDay = "Min";
            });
          }
        });
      });
    }
  }

  convertWeather() {
    weather = weatherModel?.statusWeather.toString();
    if (weather == "Sunny") {
      setState(() {
        weather = "Cerah";
        weatherStatus = 0;
      });
    } else if (weather == "Cloudy") {
      setState(() {
        weather = "Berawan";
        weatherStatus = 1;
      });
    } else if (weather == "Overcast") {
      setState(() {
        weather = "Mendung";
        weatherStatus = 1;
      });
    } else if (weather == "Mist") {
      setState(() {
        weather = "Kabut";
        weatherStatus = 1;
      });
    } else if (weather == "Patchy rain possible" ||
        weather == "Patchy sleet possible") {
      setState(() {
        weather = "Kemungkinan hujan";
        weatherStatus = 1;
      });
    } else if (weather == "Patchy light drizzle" ||
        weather == "Light drizzle") {
      setState(() {
        weather = "Hujan tidak merata";
        weatherStatus = 1;
      });
    } else if (weather == "Moderate rain at times") {
      setState(() {
        weather = "Hujan sedang kadang-kadang ";
        weatherStatus = 1;
      });
    } else if (weather == "Moderate rain") {
      setState(() {
        weather = "Hujan sedang";
        weatherStatus = 1;
      });
    } else if (weather == "Heavy rain at times") {
      setState(() {
        weather = "Hujan deras kadang-kadang";
        weatherStatus = 1;
      });
    } else if (weather == "Heavy rain") {
      setState(() {
        weather = "Hujan deras";
        weatherStatus = 1;
      });
    } else if (weather == "Light sleet") {
      setState(() {
        weather = "Hujan ringan";
        weatherStatus = 1;
      });
    } else if (weather == "Light rain shower") {
      setState(() {
        weather = "Pancuran hujan ringan";
        weatherStatus = 1;
      });
    } else if (weather == "Moderate or heavy rain shower") {
      setState(() {
        weather = "Pancuran hujan sedang atau deras";
        weatherStatus = 1;
      });
    } else if (weather == "Torrential rain shower") {
      setState(() {
        weather = "Pancuran hujan deras";
        weatherStatus = 1;
      });
    } else if (weather == "Patchy light rain with thunder") {
      setState(() {
        weather = "Hujan gerimis disertai petir";
        weatherStatus = 1;
      });
    } else if (weather == "Moderate or heavy rain with thunder") {
      setState(() {
        weather = "Hujan sedang atau lebat disertai petir";
        weatherStatus = 1;
      });
    } else {
      setState(() {
        weather = "Sebagian Berawan";
        weatherStatus = 1;
      });
    }
  }

  Future<void> getLocation() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(latitude!, longitude!);
    Placemark place = placemark[0];
    addres = "${place.subAdministrativeArea}";
  }

  Future<void> getLocationLocality() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(latitude!, longitude!);
    Placemark place = placemark[0];
    addresLocality = "${place.locality}";
  }

  Future<PermissionStatus> getLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      final result = await Permission.location.request();
      return result;
    } else {
      return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: white,
        title: SizedBox(
          height: 38,
          width: 99,
          child: SvgPicture.asset(
            "assets/svg/devin-logo-black.svg",
            color: primaryYellow,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: const SettingPage(),
                  type: PageTransitionType.rightToLeft,
                ),
              );
            },
            icon: SvgPicture.asset("assets/svg/setting.svg"),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: primaryYellow,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {
            getIsLoading();
            ref.refresh(countPCHostedRepository);
            getLocationLocality();
            getWeather();
            convertWeather();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Hai",
                              style: primaryTextStyle.copyWith(
                                fontSize: 24,
                                fontWeight: semiBold,
                                color: black,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              "assets/gif/waving-hi.gif",
                              width: 20,
                              height: 20,
                              filterQuality: FilterQuality.high,
                            ),
                          ],
                        ),
                        Text(
                          "Selamat Datang",
                          style: primaryTextStyle.copyWith(
                            fontSize: 27,
                            fontWeight: bold,
                            color: black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: weatherStatus == 0 ? primaryYellow : blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          weatherModel != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Spacer(),
                                    Image.network(
                                      "https:${weatherModel?.weatherIcon}",
                                      width: 30,
                                      height: 30,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${weatherModel?.tempC}°C",
                                      style: primaryTextStyle.copyWith(
                                        fontSize: 15,
                                        fontWeight: semiBold,
                                        color: white,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Shimmer(
                                          child: const SizedBox(
                                            height: 20,
                                            width: 70,
                                          ),
                                          color: white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          weatherModel != null
                              ? Text(
                                  addres,
                                  style: primaryTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: semiBold,
                                    color: white,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Shimmer(
                                      child: const SizedBox(
                                        height: 20,
                                        width: 200,
                                      ),
                                      color: white,
                                    ),
                                  ),
                                ),
                          weatherModel != null
                              ? Text(
                                  "$weather",
                                  style: primaryTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: regular,
                                    color: white,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Shimmer(
                                      child: const SizedBox(
                                        height: 20,
                                        width: 70,
                                      ),
                                      color: white,
                                    ),
                                  ),
                                ),
                          weatherModel != null
                              ? Text(
                                  "$formattedDay $formattedTime",
                                  style: primaryTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: regular,
                                    color: white,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Shimmer(
                                      child: const SizedBox(
                                        height: 20,
                                        width: 70,
                                      ),
                                      color: white,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Jumlah PC",
                              style: primaryTextStyle.copyWith(
                                fontSize: 24,
                                fontWeight: semiBold,
                                color: black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: height / 4,
                              width: width / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 75,
                                    width: 4,
                                    decoration: BoxDecoration(
                                      color: primaryYellow,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 60,
                                      left: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "LAB 1",
                                          style: primaryTextStyle.copyWith(
                                            fontSize: 20,
                                            fontWeight: bold,
                                            color: black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        ref
                                            .watch(countPCHostedProvider(1))
                                            .when(
                                              data: (data) => Text(
                                                "Jumlah PC: ${data?.data}",
                                                style:
                                                    primaryTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: medium,
                                                  color: greySecond,
                                                ),
                                              ),
                                              error: (error, stackTrace) =>
                                                  Text(
                                                "Jumlah PC: $error",
                                                style:
                                                    primaryTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: medium,
                                                  color: greySecond,
                                                ),
                                              ),
                                              loading: () => Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  child: Shimmer(
                                                    child: const SizedBox(
                                                      height: 10,
                                                      width: 70,
                                                    ),
                                                    color: grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: height / 4,
                              width: width / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 75,
                                    width: 4,
                                    decoration: BoxDecoration(
                                      color: primaryYellow,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 60,
                                      left: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "LAB 3",
                                          style: primaryTextStyle.copyWith(
                                            fontSize: 20,
                                            fontWeight: bold,
                                            color: black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        ref
                                            .watch(countPCHostedProvider(3))
                                            .when(
                                              data: (data) => Text(
                                                "Jumlah PC: ${data?.data}",
                                                style:
                                                    primaryTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: medium,
                                                  color: greySecond,
                                                ),
                                              ),
                                              error: (error, stackTrace) =>
                                                  Text(
                                                "Jumlah PC: $error",
                                                style:
                                                    primaryTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: medium,
                                                  color: greySecond,
                                                ),
                                              ),
                                              loading: () => Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  child: Shimmer(
                                                    child: const SizedBox(
                                                      height: 10,
                                                      width: 70,
                                                    ),
                                                    color: grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width / 20,
                        ),
                        Container(
                          height: height / 3,
                          width: width / 2.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 75,
                                width: 4,
                                decoration: BoxDecoration(
                                  color: primaryYellow,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 60,
                                  left: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "LAB 2",
                                      style: primaryTextStyle.copyWith(
                                        fontSize: 20,
                                        fontWeight: bold,
                                        color: black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    ref.watch(countPCHostedProvider(2)).when(
                                          data: (data) => Text(
                                            "Jumlah PC: ${data?.data}",
                                            style: primaryTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: medium,
                                              color: greySecond,
                                            ),
                                          ),
                                          error: (error, stackTrace) => Text(
                                            "Jumlah PC: $error",
                                            style: primaryTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: medium,
                                              color: greySecond,
                                            ),
                                          ),
                                          loading: () => Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              child: Shimmer(
                                                child: const SizedBox(
                                                  height: 10,
                                                  width: 70,
                                                ),
                                                color: grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Scanner",
        backgroundColor: primaryYellow,
        hoverColor: white,
        splashColor: primaryYellow,
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: const QRScannerPage(),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
        child: const Icon(
          Icons.qr_code_scanner_rounded,
        ),
      ),
    );
  }
}
