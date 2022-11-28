import 'package:devin/pages/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/location_service.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LocationService locationService = LocationService();
  String addres = "";
  double? latitude = 0;
  double? longitude = 0;

  @override
  void initState() {
    super.initState();
    locationService.locationStream.listen((location) {
      setState(() {
        latitude = location.latitude;
        longitude = location.longitude;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    locationService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Devin Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // themeMode: ThemeMode.system,
      home: const SplashPage(),
    );
  }
}
