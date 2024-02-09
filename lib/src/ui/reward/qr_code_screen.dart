import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';

class QrCodeGenerationScreen extends StatefulWidget {
  const QrCodeGenerationScreen({super.key});

  @override
  State<QrCodeGenerationScreen> createState() => _QrCodeGenerationScreenState();
}

class _QrCodeGenerationScreenState extends State<QrCodeGenerationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          QrImageView(

            dataModuleStyle: const QrDataModuleStyle(
              color: AppColors.primaryColor,
              dataModuleShape: QrDataModuleShape.square
            ),
            backgroundColor: AppColors.primaryWhiteColor,
          data: "https://www.instagram.com/_new_year_boy_?igsh=cTd3OHFtMm4yc2Rj",
          version: QrVersions.auto,

          embeddedImageStyle: const QrEmbeddedImageStyle(
            color: AppColors.secondaryColor,
            size: Size(200, 60),
          ),
          embeddedImage: const AssetImage(Assets.SPLASH_LOGO),
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
  }
  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   bool scanned = false;
  //   controller.scannedDataStream.listen((scanData) {
  //     if (!scanned) {
  //       scanned = true;
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => SecondRoute()),
  //       );
  //     }
  //   });
  // }
}
