import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:moing_flutter/init/init_page.dart';
import 'package:moing_flutter/login/onboarding/on_boarding_first.dart';
import 'package:moing_flutter/login/onboarding/on_boarding_second.dart';
import 'package:moing_flutter/login/onboarding/on_boarding_third.dart';
import 'package:moing_flutter/login/register_success/guide.dart';
import 'package:moing_flutter/login/register_success/welcome_page.dart';
import 'package:moing_flutter/login/sign_in/login_page.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

class MoingApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      useInheritedMediaQuery: true,
      builder: (BuildContext context, child) {
        return MaterialApp(
          navigatorKey: GetIt.I.get<GlobalKey<NavigatorState>>(),
          title: 'Moing',
          initialRoute: InitPage.routeName,
          routes: {
            /// StateLess 위젯만 필요하다면, 다음과 같이 작성!
            WelcomePage.routeName: (_) => WelcomePage(),
            RegisterGuide.routeName: (_) => RegisterGuide(),

            /// StateFul 위젯이 필요하다면, 다음과 같이 작성!
            LoginPage.routeName: (context) => LoginPage.route(context),
            InitPage.routeName: (context) => InitPage.route(context),
            OnBoardingFirstPage.routeName: (context) => OnBoardingFirstPage.route(context),
            OnBoardingSecondPage.routeName: (context) => OnBoardingSecondPage.route(context),
            OnBoardingThirdPage.routeName: (context) => OnBoardingThirdPage.route(context),
          },
          navigatorObservers: [
            GetIt.I.get<NavigationHistoryObserver>(),
          ],
        );
      },
    );
  }
}
