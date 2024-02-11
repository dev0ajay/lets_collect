import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:lets_collect/src/ui/authentication/Signup/components/widget/countryscreen/signup_country_screen.dart';
import 'package:lets_collect/src/ui/authentication/Signup/components/widget/firstscreen/sign_up_argument_class.dart';
import 'package:lets_collect/src/ui/forget_password/components/forgot_password%20arguments.dart';
import 'package:lets_collect/src/ui/reward/components/brand_and_partner_redeem_arguments.dart';
import 'package:lets_collect/src/ui/reward/components/lets_collect_redeem_screen_arguments.dart';
import 'package:lets_collect/src/ui/reward/components/widgets/filter.dart';
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
import 'package:lets_collect/src/ui/search/components/search_details_screen.dart';
import 'package:lets_collect/src/ui/search/search_screen.dart';
import 'package:lets_collect/src/ui/search/search_screen_arguments.dart';
import 'package:lets_collect/src/ui/splash/splash_screen.dart';
import '../src/ui/authentication/Signup/components/widget/calenderscreen/singup_calender_screen.dart';
import '../src/ui/authentication/Signup/components/widget/firstscreen/singup_first_last_screen.dart';
import '../src/ui/authentication/login/components/login_screen.dart';
import '../src/ui/forget_password/components/forget_password_screen.dart';
import '../src/ui/forget_password/components/widget/forget_password_confirm_screen.dart';
import '../src/ui/forget_password/components/widget/forget_password_otp_screen.dart';
import '../src/ui/home/home_screen.dart';
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
                transitionDuration: const Duration(milliseconds: 950),
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
                  NumberVerificationScreen(signUpArgumentClass: state.extra as SignUpArgumentClass

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
                child:  const HomeScreen(),
                transitionDuration: const Duration(milliseconds: 950),
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
              path: 'reward',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child:  const RewardScreen(),
                  transitionDuration: const Duration(milliseconds: 950),
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
            path: 'lets_collect_redeem',
            builder: (BuildContext context, GoRouterState state) =>
             LetsCollectRedeemScreen(redeemScreenArguments: state.extra as LetCollectRedeemScreenArguments,),
          ),
          GoRoute(
            path: 'brand_products',
            builder: (BuildContext context, GoRouterState state) =>
             BrandProductListingScreen(redeemScreenArguments: state.extra as LetCollectRedeemScreenArguments,),
          ),
          GoRoute(
            path: 'partner_products',
            builder: (BuildContext context, GoRouterState state) =>
             PartnerProductListingScreen(redeemScreenArguments: state.extra as LetCollectRedeemScreenArguments,),
          ),

          GoRoute(
              path: 'search',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const SearchScreen(),
                  transitionDuration: const Duration(milliseconds: 950),
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
            path: 'scan',
            builder: (BuildContext context, GoRouterState state) =>
                const ScanScreen(),
          ),
          GoRoute(
              path: 'long_receipt',
              builder: (BuildContext context, GoRouterState state) =>
              const LongRecieptScreen(),
          ),
          GoRoute(
            path: 'search_brand',
            builder: (BuildContext context, GoRouterState state) =>
                 SearchDetailsScreen(searchScreenArguments: state.extra as SearchScreenArguments),
          ),
          GoRoute(
              path: 'profile',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const ProfileScreen(),
                  transitionDuration: const Duration(milliseconds: 950),
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
          GoRoute(
            path: 'my_profile',
            builder: (BuildContext context, GoRouterState state) =>
             const MyProfileScreen(),
          ),
          GoRoute(
            path: 'help',
            builder: (BuildContext context, GoRouterState state) =>
                const HelpScreen()
          ),
          GoRoute(
              path: 'terms_and_condition',
              builder: (BuildContext context, GoRouterState state) =>
              const TermsAndConditionsScreen(),
          ),
          GoRoute(
            path: 'privacy_policies',
            builder: (BuildContext context, GoRouterState state) =>
            const PrivacyPoliciesScreen()
          ),
          GoRoute(
              path: 'special_offer',
              builder: (BuildContext context, GoRouterState state) =>
              const SpecialOfferScreen()
          ),
          GoRoute(
              path: 'special_offer_details',
              builder: (BuildContext context, GoRouterState state) =>
               SpecialOfferScreenDetails(offerDetailsArguments: state.extra as OfferDetailsArguments,)
          ),
          GoRoute(
              path: 'redeem_screen',
              builder: (BuildContext context, GoRouterState state) =>
               RedeemScreen(brandAndPartnerRedeemArguments: state.extra as BrandAndPartnerRedeemArguments,)
          ),
          GoRoute(
              path: 'filter_screen',
              builder: (BuildContext context, GoRouterState state) =>
              const FilterSheet(),
          ),
          GoRoute(
            path: 'scan_history',
            builder: (BuildContext context, GoRouterState state) =>
             const ScanHistoryDetailsScreen(),
          ),
          GoRoute(
            path: 'qr_code',
            builder: (BuildContext context, GoRouterState state) =>
             QrCodeGenerationScreen(qrUrl: state.extra as String)
          ),
        ],
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),


      ),
    ],
  );

  static GoRouter get router => _router;
}
