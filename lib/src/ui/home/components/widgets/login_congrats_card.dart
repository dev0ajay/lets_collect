import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';

class LoginCongratsCard extends StatefulWidget {
   LoginCongratsCard(
      {super.key, required this.isDone, required this.emailVerifiedPoints});

   late  bool isDone;
   // late bool isOneTime;
  final String emailVerifiedPoints;

  @override
  State<LoginCongratsCard> createState() => _LoginCongratsCardState();
}

class _LoginCongratsCardState extends State<LoginCongratsCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: 40,
      right: 40,
      top: widget.isDone ? MediaQuery.of(context).size.height / 3 : -420,
      duration: const Duration(milliseconds: 400),
      child: RepaintBoundary(

        child: Card(
          color: AppColors.primaryWhiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 12,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      widget.isDone = false;
                    });
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              CardContent(
                isDone: widget.isDone,
                emailVerifiedPoints: widget.emailVerifiedPoints,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardContent extends StatefulWidget {
  const CardContent(
      {super.key, required this.isDone, required this.emailVerifiedPoints});

  final bool isDone;
  final String emailVerifiedPoints;

  @override
  State<CardContent> createState() => _CardContentState();
}

class _CardContentState extends State<CardContent>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }


  @override
  void didUpdateWidget(covariant CardContent oldWidget) {
    // TODO: implement didUpdateWidget
    if (!oldWidget.isDone && widget.isDone) {
      animationController.forward(from: 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        // const SizedBox(height: 40),
        ScaleTransition(

          scale: CurvedAnimation(
              parent: animationController, curve: Curves.elasticOut),
          child:
              // ImageIcon(AssetImage(Assets.GIFT_ICON),color: AppColors.secondaryButtonColor,size: 25,)
              Image.asset(Assets.GIFT_ICON),
        ),
        const SizedBox(height: 10),
        Text(
          "Congratulations !",
          style: GoogleFonts.openSans(
            color: AppColors.secondaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "You have earned",
          style: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.cardTextColor,
          ),
        ),
        Text(
          widget.emailVerifiedPoints,
          style: GoogleFonts.openSans(
            color: AppColors.cardTextColor,
            fontSize: 44,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "Points",
          style: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.cardTextColor,
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
            fixedSize: const Size(121, 36),
            backgroundColor: AppColors.secondaryColor,

          ),
          onPressed: () {},
          child: Text("Yay!",style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryWhiteColor,
          ),),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
