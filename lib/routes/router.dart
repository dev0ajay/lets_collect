import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:lets_collect/src/ui/authentication/Signup/components/widget/countryscreen/signup_country_screen.dart';
import 'package:lets_collect/src/ui/authentication/Signup/components/widget/firstscreen/sign_up_argument_class.dart';
import 'package:lets_collect/src/ui/forget_password/components/forgot_password%20arguments.dart';
import 'package:lets_collect/src/ui/notification/notification_screen.dart';
import 'package:lets_collect/src/ui/profile/components/contact_us.dart';
import 'package:lets_collect/src/ui/profile/components/how_to_redeem_my_points_screen.dart';
import 'package:lets_collect/src/ui/profile/components/point_calculation_screen.dart';
import 'package:lets_collect/src/ui/profile/components/point_tracker_details_screen.dart';
import 'package:lets_collect/src/ui/profile/components/point_tracker_screen.dart';
import 'package:lets_collect/src/ui/profile/components/purchase_history_details_screen.dart';
import 'package:lets_collect/src/ui/profile/components/purchase_history_screen.dart';
import 'package:lets_collect/src/ui/profile/components/redemption_tracker_screen.dart';
import 'package:lets_collect/src/ui/profile/components/redemption_details_screen.dart';
import 'package:lets_collect/src/ui/profile/components/refer_a_friend.dart';
import 'package:lets_collect/src/ui/reward/components/brand_and_partner_redeem_arguments.dart';
import 'package:lets_collect/src/ui/reward/components/lets_collect_redeem_screen_arguments.dart';
import 'package:lets_collect/src/ui/reward/components/qr_code_screen_arguments.dart';
import 'package:lets_collect/src/ui/reward/qr_code_screen.dart';
import 'package:lets_collect/src/ui/scan/scan_history_screen.dart';
import 'package:lets_collect/src/ui/special_offer/components/offer_details_arguments.dart';
import 'package:lets_collect/src/ui/special_offer/special_offer_details_screen.dart';
import 'package:lets_collect/src/ui/special_offer/special_offer_screen.dart';
import 'package:lets_collect/src/ui/profile/components/help_screen.dart';
import 'package:lets_collect/src/ui/profile/components/my_profile_screen.dart';
import 'package:lets_collect/src/ui/profile/components/privacy_policies.dart';
import 'package:lets_collect/src/ui/profile/components/terms_and_conditions.dart';
import 'package:lets_collect/src/ui/reward/components/brand/brand_product_listing_screen.dart';
import 'package:lets_collect/src/ui/reward/components/lets_collect/lets_collect_redeem_screen.dart';
import 'package:lets_collect/src/ui/reward/components/partner/partner_product_listing_screen.dart';
import 'package:lets_collect/src/ui/reward/components/redeem_screen.dart';
import 'package:lets_collect/src/ui/reward/reward_screen.dart';
import 'package:lets_collect/src/ui/scan/long_reciept_screen.dart';
import 'package:lets_collect/src/ui/search/search_details_screen.dart';
import 'package:lets_collect/src/ui/search/search_screen.dart';
import 'package:lets_collect/src/ui/search/components/search_screen_arguments.dart';
import 'package:lets_collect/src/ui/splash/splash_screen.dart';
import '../src/ui/authentication/Signup/components/widget/calenderscreen/singup_calender_screen.dart';
import '../src/ui/authentication/Signup/components/widget/firstscreen/singup_first_screen.dart';
import '../src/ui/authentication/login/components/login_screen.dart';
import '../src/ui/forget_password/components/forget_password_screen.dart';
import '../src/ui/forget_password/components/widget/forget_password_confirm_screen.dart';
import '../src/ui/forget_password/components/widget/forget_password_otp_screen.dart';
import '../src/ui/home/home_screen.dart';
import '../src/ui/profile/components/my_profile_screen_arguments.dart';
import '../src/ui/profile/profile_screen.dart';
import '../src/ui/scan/components/scan_detail_screen_argument.dart';
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
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'signUpCountryScreen',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: NumberVerificationScreen(
                      signUpArgumentClass: state.extra as SignUpArgumentClass),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'signUpCalenderScreen',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: SignupCalenderScreen(
                      signUpArgumentClass: state.extra as SignUpArgumentClass),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'signUp',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: SignUpFirstScreen(
                    from: state.extra as String,
                    gUserMail: state.extra as String,
                  ),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'home',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const HomeScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'reward',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const RewardScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'lets_collect_redeem',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: LetsCollectRedeemScreen(
                    redeemScreenArguments:
                    state.extra as LetCollectRedeemScreenArguments,
                  ),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'brand_products',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: BrandProductListingScreen(
                    redeemScreenArguments:
                    state.extra as LetCollectRedeemScreenArguments,
                  ),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'partner_products',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: PartnerProductListingScreen(
                    redeemScreenArguments:
                    state.extra as LetCollectRedeemScreenArguments,
                  ),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'search',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const SearchScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'scan',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: ScanScreen(from: state.extra as String),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'long_receipt',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const LongRecieptScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'search_brand',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: SearchDetailsScreen(
                      searchScreenArguments:
                      state.extra as SearchScreenArguments),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'profile',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const ProfileScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'forgot_password_email',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const ForgetPasswordScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'forgot_password_otp',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: ForgetPasswordOtpScreen(
                      forgotPasswordArguments:
                      state.extra as ForgotPasswordArguments),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'forgot_password_reset',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const ForgetPasswordConfirmScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'my_profile',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: MyProfileScreen(
                      myProfileArguments: state.extra as MyProfileArguments),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'help',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const HelpScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'terms_and_condition',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const TermsAndConditionsScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'privacy_policies',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const PrivacyPoliciesScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'special_offer',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const SpecialOfferScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'special_offer_details',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: SpecialOfferScreenDetails(
                    offerDetailsArguments: state.extra as OfferDetailsArguments,
                  ),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'redeem_screen',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: RedeemScreen(
                    brandAndPartnerRedeemArguments:
                    state.extra as BrandAndPartnerRedeemArguments,
                  ),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'scan_history',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: ScanHistoryDetailsScreen(
                    scanDetailsScreenArgument:
                    state.extra as ScanDetailsScreenArgument,
                    onIndexChanged: (int) {},
                  ),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'qr_code',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: QrCodeGenerationScreen(
                      qrCodeScreenArguments:
                      state.extra as QrCodeScreenArguments),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'purchase_history',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const PurchaseHistoryScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'purchase_history_details',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: PurchaseHistoryDetailsScreen(
                      receiptId: state.extra as String),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'point_tracker',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const PointTrackerScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'point_tracker_details',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: PointTrackerDetailsScreen(pointId: state.extra as int),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'notification',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const NotificationScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'how_to_redeem',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const HowToRedeemMyPointsScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'point_calculation',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const PointCalculationsScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'contact_us',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const ContactUsScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'redemption',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const RedemptionTrackerScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'redemption_details',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: RedemptionDetailsScreen(
                      imageUrl: state.extra as String,
                      itemName: state.extra as String,
                      points: state.extra as int,
                      time: state.extra as String,
                      store: state.extra as String),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
          GoRoute(
              path: 'referral',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const ReferralScreen(),
                  transitionDuration: const Duration(milliseconds: 450),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                      CurveTween(curve: Curves.easeIn).animate(animation),
                      child: child,
                    );
                  },
                );
              }),
        ],
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
        const SplashScreen(),
      ),
    ],
  );

  static GoRouter get router => _router;
}