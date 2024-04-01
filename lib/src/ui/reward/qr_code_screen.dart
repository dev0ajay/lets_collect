import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import 'components/qr_code_screen_arguments.dart';

 class QrCodeGenerationScreen extends StatefulWidget {
  final QrCodeScreenArguments qrCodeScreenArguments;
  const QrCodeGenerationScreen({super.key,required this.qrCodeScreenArguments});

  @override
  State<QrCodeGenerationScreen> createState() => _QrCodeGenerationScreenState();
}

class _QrCodeGenerationScreenState extends State<QrCodeGenerationScreen> {
  @override
  void initState() {
    super.initState();
    print("QRURL: ${widget.qrCodeScreenArguments.qrUrl}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryWhiteColor,
        leading: IconButton(onPressed: () {
          context.pop();
        }, icon: const Icon(Icons.arrow_back_ios,color: AppColors.primaryColor,)),
      ),
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
