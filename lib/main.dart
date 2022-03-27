import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/app/amplify_configure.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AmplifyConfiguration.instance.init();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: locator<NavigationService>().navigatorKey,
        scaffoldMessengerKey: SnackBarService.rootScaffoldMessengerKey,
        title: 'Imgur(Tech387)',
        theme: ThemeData(
          fontFamily: 'Proxima Nova',
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppPages.initial,
        onGenerateRoute: AppPages.onGenerateRoute,    
    );
  }
}
