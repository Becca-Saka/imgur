import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/ui/views/home.dart';
import 'package:imgur/ui/views/main_view.dart';
import 'package:imgur/ui/views/rearrange_images_view.dart';
import 'package:imgur/ui/views/signup_view.dart';
import 'package:imgur/ui/views/single_feed_view.dart';
import 'package:imgur/ui/views/startup_view.dart';
import 'package:imgur/ui/views/upload_view.dart';
part 'app_routes.dart';

class AppPages {
  static const initial = Routes.root;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const StartUpView(),
          settings: settings,
        );
      case Routes.mainView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const MainView(),
          settings: settings,
        );
      case Routes.signup:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const SignUpView(),
          settings: settings,
        );
      case Routes.uploadView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const UploadView(),
          settings: settings,
        );
      case Routes.rearrangeView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const ReArrageImagesView(),
          settings: settings,
        );
      case Routes.singleFeedItem:
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            final arg = settings.arguments as FeedModel;
            return SingleFeedView(
              feed: arg,
            );
          },
          settings: settings,
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const HomeView(),
          settings: settings,
        );
    }
  }

  // static final routes = [
  //   const MaterialPage(
  //     name: Routes.root,
  //     child: HomeView(),
  //   ),
  //   const MaterialPage(
  //     name: Routes.signup,
  //     child: SignUpView(),
  //   ),
  // ];
}
