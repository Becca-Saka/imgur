import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/data/controllers/authentication_controller.dart';
import 'package:imgur/data/services/amplify_services.dart';
import 'package:imgur/data/services/authentication_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AmplifyService.instance.init();
  setupLocator();
  runApp(const MyApp());
}

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
          fontFamily: 'Roboto',
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppPages.initial,
        onGenerateRoute: AppPages.onGenerateRoute,
        // home: const SignUpView(),
      ),
    );
  }
}
