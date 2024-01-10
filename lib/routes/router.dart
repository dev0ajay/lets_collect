import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:lets_collect/src/ui/authentication/Signup/components/widget/countryscreen/signup_country_screen.dart';
import 'package:lets_collect/src/ui/authentication/Signup/components/widget/firstscreen/sign_up_argument_class.dart';
import 'package:lets_collect/src/ui/forget_password/components/forgot_password%20arguments.dart';
import 'package:lets_collect/src/ui/profile/components/help_screen.dart';
import 'package:lets_collect/src/ui/profile/components/my_profile_screen.dart';
import 'package:lets_collect/src/ui/profile/components/notification_center_screen.dart';
import 'package:lets_collect/src/ui/profile/components/point_tracker_screen.dart';
import 'package:lets_collect/src/ui/profile/components/purchase_history_screen.dart';
import 'package:lets_collect/src/ui/profile/components/redem_tracker_screen.dart';
import 'package:lets_collect/src/ui/reward/reward_screen.dart';
import 'package:lets_collect/src/ui/search/search_screen.dart';
import '../src/ui/authentication/Signup/components/widget/calenderscreen/singup_calender_screen.dart';
import '../src/ui/authentication/Signup/components/widget/firstscreen/singup_first_last_screen.dart';
import '../src/ui/authentication/login/components/login_screen.dart';
import '../src/ui/forget_password/components/forget_password_screen.dart';
import '../src/ui/forget_password/components/widget/forget_password_confirm_screen.dart';
import '../src/ui/forget_password/components/widget/forget_password_otp_screen.dart';
import '../src/ui/home/home_screen.dart';
import '../src/ui/profile/profile_screen.dart';
import '../src/ui/scan/scan_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    // errorBuilder: (context, state) => ErrorScreen(error:state.error),
    routes: <GoRoute>[
      GoRoute(
        routes: <GoRoute>[
          GoRoute(
            path: 'login',
            pageBuilder: (BuildContext context, GoRouterState state) {
           return CustomTransitionPage<void>(
                key: state.pageKey,
                child: const Login_screen(),
                transitionDuration: const Duration(milliseconds: 150),
                transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) {
                  // Change the opacity of the screen using a Curve based on the the animation's
                  // value
                  return FadeTransition(
                    opacity:
                    CurveTween(curve: Curves.easeInOut).animate(animation),
                    child: child,
                  );
                },
              );
            }

          ),
          GoRoute(
            path: 'signUpCountryScreen',
            builder: (BuildContext context, GoRouterState state) =>
                  NumbereverificationScreen(signUpArgumentClass: state.extra as SignUpArgumentClass

            ),
          ),
          GoRoute(
            path: 'signUpCalenderScreen',
            builder: (BuildContext context, GoRouterState state) =>
                  SignupCalenderScreen(
                      signUpArgumentClass: state.extra as SignUpArgumentClass
                ),
          ),
          GoRoute(
            path: 'signUp',

            builder: (BuildContext context, GoRouterState state) =>
            const SignupUiwidget1(),

          ),


          GoRoute(
            path: 'home',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: const HomeScreen(),
                transitionDuration: const Duration(milliseconds: 750),
                transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) {
                  // Change the opacity of the screen using a Curve based on the the animation's
                  // value
                  return FadeTransition(
                    opacity:
                    CurveTween(curve: Curves.easeInOut).animate(animation),
                    child: child,
                  );
                },
              );
            }

          ),
          GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) =>
                const HomeScreen(),
          ),
          GoRoute(
            path: 'reward',
            builder: (BuildContext context, GoRouterState state) =>
                const RewardScreen(),
          ),
          GoRoute(
            path: 'scan',
            builder: (BuildContext context, GoRouterState state) =>
                const ScanScreen(),
          ),
          GoRoute(
            path: 'search',
            builder: (BuildContext context, GoRouterState state) =>
                 SearchScreen(),
          ),
          GoRoute(
            path: 'profile',
            builder: (BuildContext context, GoRouterState state) =>
                const ProfileScreen(),
          ),

          GoRoute(
            path: 'myProfile',
            builder: (BuildContext context, GoRouterState state) =>
                MyProfileScreen(),
          ),
          GoRoute(
            path: 'pointTracker',
            builder: (BuildContext context, GoRouterState state) =>
            const PointTrackerScreen(),
          ),
          GoRoute(
            path: 'redemption tracker',
            builder: (BuildContext context, GoRouterState state) =>
            const RedeemTrackerScreen(),
          ),
          GoRoute(
            path: 'purchaseHistory',
            builder: (BuildContext context, GoRouterState state) =>
            const PurchaseHistoryScreen(),
          ),
          GoRoute(
            path: 'help',
            builder: (BuildContext context, GoRouterState state) =>
            const HelpScreen(),
          ),
          GoRoute(
            path: 'notificationCenter',
            builder: (BuildContext context, GoRouterState state) =>
            const NotificationScreen(),
          ),

          GoRoute(
            path: 'forgot_password_email',
            builder: (BuildContext context, GoRouterState state) =>
            const Forget_password_screen(),
          ),
          GoRoute(
            path: 'forgot_password_otp',
            builder: (BuildContext context, GoRouterState state) =>
             ForgetPasswordOtpScreen(forgotPasswordArguments: state.extra as ForgotPasswordArguments),
          ),
          GoRoute(
            path: 'forgot_password_reset',
            builder: (BuildContext context, GoRouterState state) =>
            const ForgetPasswordConfirmScreen(),
          ),
        ],
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const Login_screen(),
        // const NumbereverificationScreen(
        //   firstname: "firstname",
        //   lastname: "lastname",
        //   email: "email",
        //   password: "password",
        // ),
      ),
    ],
  );

  static GoRouter get router => _router;
}
