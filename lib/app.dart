import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/routes/router.dart';
import 'package:lets_collect/src/bloc/city_bloc/city_bloc.dart';
import 'package:lets_collect/src/bloc/cms_bloc/privacy_policies/privacy_policies_bloc.dart';
import 'package:lets_collect/src/bloc/cms_bloc/terms_and_condition_bloc.dart';
import 'package:lets_collect/src/bloc/country_bloc/country_bloc.dart';
import 'package:lets_collect/src/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:lets_collect/src/bloc/home_bloc/home_bloc.dart';
import 'package:lets_collect/src/bloc/nationality_bloc/nationality_bloc.dart';
import 'package:lets_collect/src/bloc/search_bloc/search_bloc.dart';
import 'package:lets_collect/src/constants/app_theme_data.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/resources/api_providers/auth_provider.dart';
import 'package:lets_collect/src/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:lets_collect/src/bloc/login_bloc/login_bloc.dart';
import 'package:lets_collect/src/resources/api_providers/home_provider.dart';
import 'package:lets_collect/src/resources/api_providers/profile_provider.dart';
import 'package:lets_collect/src/resources/api_providers/search_provider.dart';
import 'package:lets_collect/src/ui/home/home_screen.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lets_collect/src/utils/network_connectivity/network_helper.dart';
import 'package:lottie/lottie.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (create) => AuthProvider(),
        ),
        RepositoryProvider(
          create: (create) => HomeDataProvider(),
        ),
        RepositoryProvider(
          create: (create) => ProfileDataProvider(),
        ),
        RepositoryProvider(
          create: (create) => SearchProvider(),
        ),
        RepositoryProvider(
          create: (create) => NetworkHelper(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NetworkBloc>(
            create: (BuildContext context) =>
                NetworkBloc()..add(NetworkObserve()),
          ),
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
        ],
        child: BlocBuilder<NetworkBloc, NetworkState>(
          builder: (context, state) {
            if (state is NetworkFailure) {
              Center(
                child: Column(
                  children: [
                    Lottie.asset(Assets.NO_INTERNET),
                    Text(
                      "You are not connected to the internet",
                      style: GoogleFonts.openSans(
                        color: AppColors.primaryWhiteColor,
                        fontSize: 20,
                      ),
                    ).animate().scale(delay: 200.ms, duration: 300.ms),
                  ],
                ),
              );
            }
            return MaterialApp.router(
              // routerConfig: AppRouter.router,
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
                  // Set the default textScaleFactor to 1.0 for
                  // the whole subtree.
                  data: mediaQueryData.copyWith(textScaleFactor: 0.85),
                  child: child!,
                );
              },
              // themeMode: appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
              // home: const HomeScreen(),/
              // SplashScreen(isOffline: isOffline),
              // home: OrderSuccessScreen(),
              // home: LoadUrl(urlPath: "https://www.google.com",),
              // home: PushNotify(),
              // home:Registration(),
            );
          },
        ),
      ),
    );
  }
}
