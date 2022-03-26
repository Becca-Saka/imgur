import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/data/controllers/authentication_controller.dart';
import 'package:imgur/app/amplify_configure.dart';
import 'package:imgur/data/services/shared_preferences.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AmplifyConfiguration.instance.init();
  setupLocator();
  runApp(const MyApp());
}
//TODO: get accestoken from webview
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationController(),
      child: MaterialApp( 
        navigatorKey: locator<NavigationService>().navigatorKey,
         scaffoldMessengerKey: SnackBarService.rootScaffoldMessengerKey,
        title: 'Imgur(Tech387)',
        theme: ThemeData(
          fontFamily: 'Proxima Nova',
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppPages.initial,
        onGenerateRoute: AppPages.onGenerateRoute,
      ),
    );
  }
}
