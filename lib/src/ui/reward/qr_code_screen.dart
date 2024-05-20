import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../utils/network_connectivity/bloc/network_bloc.dart';
import 'components/qr_code_screen_arguments.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QrCodeGenerationScreen extends StatefulWidget {
  final QrCodeScreenArguments qrCodeScreenArguments;

  const QrCodeGenerationScreen(
      {super.key, required this.qrCodeScreenArguments});

  @override
  State<QrCodeGenerationScreen> createState() => _QrCodeGenerationScreenState();
}

class _QrCodeGenerationScreenState extends State<QrCodeGenerationScreen> {
  @override
  void initState() {
    super.initState();
    // print("QRURL: ${widget.qrCodeScreenArguments.qrUrl}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NetworkBloc, NetworkState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is NetworkSuccess) {
          return Scaffold(
            backgroundColor: AppColors.primaryWhiteColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.primaryWhiteColor,
              leading: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primaryColor,
                  )),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QrImageView(
                    dataModuleStyle: const QrDataModuleStyle(
                        color: AppColors.primaryColor,
                        dataModuleShape: QrDataModuleShape.square),
                    backgroundColor: AppColors.primaryWhiteColor,
                    data: widget.qrCodeScreenArguments.qrUrl,
                    version: QrVersions.auto,
                    embeddedImageStyle: const QrEmbeddedImageStyle(
                      color: AppColors.secondaryColor,
                      size: Size(200, 60),
                    ),
                    embeddedImage: const AssetImage(Assets.SPLASH_LOGO),
                    embeddedImageEmitsError: true,
                    size: 320,
                    gapless: false,
                    errorStateBuilder: (cxt, err) {
                      return const Center(
                        child: Text(
                          'Uh oh! Something went wrong...',
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else if (state is NetworkFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(Assets.NO_INTERNET),
                Text(
                  // "You are not connected to the internet",
                  AppLocalizations.of(context)!.youarenotconnectedtotheinternet,
                  style: GoogleFonts.openSans(
                    color: AppColors.primaryGrayColor,
                    fontSize: 20,
                  ),
                ).animate().scale(delay: 200.ms, duration: 300.ms),
              ],
            ),
          );
        } else if (state is NetworkInitial) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(Assets.NO_INTERNET),
                Text(
                  // "You are not connected to the internet",
                  AppLocalizations.of(context)!.youarenotconnectedtotheinternet,
                  style: GoogleFonts.openSans(
                    color: AppColors.primaryGrayColor,
                    fontSize: 20,
                  ),
                ).animate().scale(delay: 200.ms, duration: 300.ms),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
