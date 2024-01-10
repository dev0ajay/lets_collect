import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_collect/routes/router.dart';
import 'package:lets_collect/src/bloc/brand_bloc/brand_bloc.dart';
import 'package:lets_collect/src/bloc/city_bloc/city_bloc.dart';
import 'package:lets_collect/src/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:lets_collect/src/bloc/search_bloc/search_bloc.dart';
import 'package:lets_collect/src/constants/app_theme_data.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/resources/api_providers/auth_provider.dart';
import 'package:lets_collect/src/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:lets_collect/src/bloc/login_bloc/login_bloc.dart';
import 'package:lets_collect/src/resources/api_providers/search_provider.dart';
import 'package:lets_collect/src/ui/home/home_screen.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lets_collect/src/utils/network_connectivity/network_helper.dart';

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
          BlocProvider<ForgotPasswordBloc>(
            create: (BuildContext context) => ForgotPasswordBloc(
                authProvider: RepositoryProvider.of(context)),
          ),
          BlocProvider<SearchBloc>(
            create: (BuildContext context) => SearchBloc(
              searchProvider: RepositoryProvider.of(context),
            ),
          ),
          BlocProvider<BrandBloc>(
            create: (BuildContext context) => BrandBloc(
              searchProvider: RepositoryProvider.of(context),
            ),
          ),
        ],
        child: BlocConsumer<NetworkBloc, NetworkState>(
          listener: (context, state) {
            if (state is NetworkFailure) {
              Material(
                color: AppColors.primaryWhiteColor,
                child: Center(
                  child: const Text("You are not connected to the internet")
                      .animate()
                      .scale(delay: 200.ms, duration: 300.ms),
                ),
              );
            }
          },
          builder: (context, state) {
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
