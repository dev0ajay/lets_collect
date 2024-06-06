import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_collect/routes/router.dart';
import 'package:lets_collect/src/bloc/apple_sign_in_cubit/apple_signin_cubit.dart';
import 'package:lets_collect/src/bloc/brand_and_partner_product_bloc/brand_and_partner_product_bloc.dart';
import 'package:lets_collect/src/bloc/change_password_bloc/change_password_bloc.dart';
import 'package:lets_collect/src/bloc/city_bloc/city_bloc.dart';
import 'package:lets_collect/src/bloc/contact_us_bloc/contact_us_bloc.dart';
import 'package:lets_collect/src/bloc/country_bloc/country_bloc.dart';
import 'package:lets_collect/src/bloc/delete_account/delete_account_bloc.dart';
import 'package:lets_collect/src/bloc/facebook_cubit/facebook_signin_cubit.dart';
import 'package:lets_collect/src/bloc/filter_bloc/filter_bloc.dart';
import 'package:lets_collect/src/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:lets_collect/src/bloc/google_signIn_cubit/google_sign_in_cubit.dart';
import 'package:lets_collect/src/bloc/home_bloc/home_bloc.dart';
import 'package:lets_collect/src/bloc/how_to_redeem/how_to_redeem_my_points_bloc.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/bloc/language/language_state.dart';
import 'package:lets_collect/src/bloc/language_selection_bloc/language_selection_bloc.dart';
import 'package:lets_collect/src/bloc/my_profile_bloc/my_profile_bloc.dart';
import 'package:lets_collect/src/bloc/nationality_bloc/nationality_bloc.dart';
import 'package:lets_collect/src/bloc/notification/notification_bloc.dart';
import 'package:lets_collect/src/bloc/offer_bloc/offer_bloc.dart';
import 'package:lets_collect/src/bloc/point_calculation/point_calculations_bloc.dart';
import 'package:lets_collect/src/bloc/point_tracker_bloc/point_tracker_bloc.dart';
import 'package:lets_collect/src/bloc/privacy_policies/privacy_policies_bloc.dart';
import 'package:lets_collect/src/bloc/purchase_history_bloc/purchase_history_bloc.dart';
import 'package:lets_collect/src/bloc/redeem/redeem_bloc.dart';
import 'package:lets_collect/src/bloc/redemption_history/redemption_history_bloc.dart';
import 'package:lets_collect/src/bloc/referral_bloc/referral_bloc.dart';
import 'package:lets_collect/src/bloc/reward_tier_bloc/reward_tier_bloc.dart';
import 'package:lets_collect/src/bloc/scan_bloc/scan_bloc.dart';
import 'package:lets_collect/src/bloc/search_bloc/search_bloc.dart';
import 'package:lets_collect/src/bloc/terms_and_conditions_bloc/terms_and_condition_bloc.dart';
import 'package:lets_collect/src/constants/app_theme_data.dart';
import 'package:lets_collect/src/resources/api_providers/auth_provider.dart';
import 'package:lets_collect/src/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:lets_collect/src/bloc/login_bloc/login_bloc.dart';
import 'package:lets_collect/src/resources/api_providers/home_screen_provider.dart';
import 'package:lets_collect/src/resources/api_providers/notification_providers.dart';
import 'package:lets_collect/src/resources/api_providers/profile_screen_provider.dart';
import 'package:lets_collect/src/resources/api_providers/purchase_data_provider.dart';
import 'package:lets_collect/src/resources/api_providers/referral_provider.dart';
import 'package:lets_collect/src/resources/api_providers/reward_screen_provider.dart';
import 'package:lets_collect/src/resources/api_providers/scan_receipt_provider.dart';
import 'package:lets_collect/src/resources/api_providers/search_provider.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lets_collect/src/utils/network_connectivity/network_helper.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (create) => AuthDataProvider(),
          ),
          RepositoryProvider(
            create: (create) => HomeDataProvider(),
          ),
          RepositoryProvider(
            create: (create) => ProfileScreenProvider(),
          ),
          RepositoryProvider(
            create: (create) => SearchProvider(),
          ),
          RepositoryProvider(
            create: (create) => NetworkHelper(),
          ),
          RepositoryProvider(
            create: (create) => RewardScreenProvider(),
          ),
          RepositoryProvider(
            create: (create) => ScanReceiptApiProvider(),
          ),
          RepositoryProvider(
            create: (create) => PurchaseDataProvider(),
          ),
          RepositoryProvider(
            create: (create) => NotificationProvider(),
          ),
          RepositoryProvider(
            create: (create) => ReferralProvider(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<NetworkBloc>(
              create: (BuildContext context) =>
                  NetworkBloc()..add(NetworkObserve()),
            ),
            BlocProvider<LanguageBloc>(
              create: (context) => LanguageBloc(profileScreenProvider:  RepositoryProvider.of(context),)),

            BlocProvider<SignUpBloc>(
              create: (BuildContext context) => SignUpBloc(
                authProvider: RepositoryProvider.of(context),
              ),
            ),
            BlocProvider<LoginBloc>(
              create: (BuildContext context) => LoginBloc(
                authProvider: RepositoryProvider.of(context),
              ),
            ),
            BlocProvider<CityBloc>(
              create: (BuildContext context) => CityBloc(
                authProvider: RepositoryProvider.of(context),
              ),
            ),
            BlocProvider<NationalityBloc>(
              create: (BuildContext context) =>
                  NationalityBloc(authProvider: RepositoryProvider.of(context)),
            ),
            BlocProvider<CountryBloc>(
              create: (BuildContext context) => CountryBloc(
                authProvider: RepositoryProvider.of(context),
              ),
            ),
            BlocProvider<SearchBloc>(
                create: (BuildContext context) =>
                    SearchBloc(searchProvider: RepositoryProvider.of(context))),
            BlocProvider<ForgotPasswordBloc>(
              create: (BuildContext context) => ForgotPasswordBloc(
                  authProvider: RepositoryProvider.of(context)),
            ),
            BlocProvider<HomeBloc>(
              create: (BuildContext context) =>
                  HomeBloc(homeDataProvider: RepositoryProvider.of(context)),
            ),
            BlocProvider<TermsAndConditionBloc>(
              create: (BuildContext context) => TermsAndConditionBloc(
                profileDataProvider: RepositoryProvider.of(context),
              ),
            ),
            BlocProvider<PrivacyPoliciesBloc>(
              create: (BuildContext context) => PrivacyPoliciesBloc(
                profileDataProvider: RepositoryProvider.of(context),
              ),
            ),
            BlocProvider<FilterBloc>(
              create: (BuildContext context) => FilterBloc(
                rewardScreenProvider: RepositoryProvider.of(context),
                superMarketListProvider: RepositoryProvider.of(context),
              ),
            ),
            BlocProvider<RewardTierBloc>(
              create: (BuildContext context) => RewardTierBloc(
                rewardScreenProvider: RepositoryProvider.of(context),
              ),
            ),
            BlocProvider<BrandAndPartnerProductBloc>(
              create: (BuildContext context) => BrandAndPartnerProductBloc(
                rewardScreenProvider: RepositoryProvider.of(context),
              ),
            ),
            BlocProvider<ScanBloc>(
              create: (BuildContext context) => ScanBloc(
                scanReceiptApiProvider: RepositoryProvider.of(context),
              ),
            ),
            BlocProvider<GoogleSignInCubit>(
              create: (BuildContext context) => GoogleSignInCubit(),
            ),
            BlocProvider<OfferBloc>(
                create: (BuildContext context) => OfferBloc(
                    homeDataProvider: RepositoryProvider.of(context))),
            BlocProvider<RedeemBloc>(
                create: (BuildContext context) => RedeemBloc(
                    rewardScreenProvider: RepositoryProvider.of(context))),
            BlocProvider<PurchaseHistoryBloc>(
                create: (BuildContext context) => PurchaseHistoryBloc(
                    purchaseHistoryDataProvider:
                        RepositoryProvider.of(context))),
            BlocProvider<MyProfileBloc>(
              create: (BuildContext context) => MyProfileBloc(
                  myProfileDataProvider: RepositoryProvider.of(context)),
            ),
            BlocProvider<PointTrackerBloc>(
              create: (BuildContext context) => PointTrackerBloc(
                  pointTrackerProvider: RepositoryProvider.of(context)),
            ),
            BlocProvider<NotificationBloc>(
              create: (BuildContext context) => NotificationBloc(
                  notificationProvider: RepositoryProvider.of(context)),
            ),
            BlocProvider<ContactUsBloc>(
              create: (BuildContext context) => ContactUsBloc(
                myProfileDataProvider: RepositoryProvider.of(context),
              ),
            ),
            BlocProvider<HowToRedeemMyPointsBloc>(
              create: (BuildContext context) => HowToRedeemMyPointsBloc(
                profileDataProvider: RepositoryProvider.of(context),
              ),
            ),
            BlocProvider<PointCalculationsBloc>(
              create: (BuildContext context) => PointCalculationsBloc(
                profileDataProvider: RepositoryProvider.of(context),
              ),
            ),
            BlocProvider<DeleteAccountBloc>(
              create: (BuildContext context) => DeleteAccountBloc(
                profileDataProvider: RepositoryProvider.of(context),
              ),
            ),
            BlocProvider<AppleSignInCubit>(
              create: (BuildContext context) => AppleSignInCubit(),
            ),
            BlocProvider<RedemptionHistoryBloc>(
                create: (BuildContext context) => RedemptionHistoryBloc(
                    profileDataProvider: RepositoryProvider.of(context))),
            BlocProvider<ReferralBloc>(
              create: (BuildContext context) => ReferralBloc(
                  referralProvider: RepositoryProvider.of(context)),
            ),
            BlocProvider<FacebookSignInCubit>(
              create: (BuildContext context) => FacebookSignInCubit(),
            ),
            BlocProvider<ChangePasswordBloc>(
              create: (BuildContext context) => ChangePasswordBloc(
                  myProfileDataProvider: RepositoryProvider.of(context)),
            ),
            BlocProvider<LanguageSelectionBloc>(
              create: (BuildContext context) => LanguageSelectionBloc(
    profileScreenProvider: RepositoryProvider.of(context),
            ),),
          ],
          child: BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              return MaterialApp.router(
                locale: state.selectedLanguage.value,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                themeAnimationCurve: Curves.easeIn,
                themeAnimationDuration: const Duration(milliseconds: 750),
                routerDelegate: AppRouter.router.routerDelegate,
                routeInformationProvider:
                    AppRouter.router.routeInformationProvider,
                routeInformationParser: AppRouter.router.routeInformationParser,
                debugShowCheckedModeBanner: false,
                title: 'Lets Collect',
                theme: AppTheme.lightTheme,
                themeMode: ThemeMode.light,
                builder: (context, child) {
                  // Obtain the current media query information.
                  final mediaQueryData = MediaQuery.of(context);

                  return MediaQuery(
                    // Set the default textScaleFactor to 0.85 for
                    // the whole subtree.
                    data: mediaQueryData.copyWith(
                        textScaler: const TextScaler.linear(0.85)),
                    child: child!,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
