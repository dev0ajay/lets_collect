import 'package:flutter/material.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';

class LoginCongratsCard extends StatefulWidget {
  LoginCongratsCard({super.key, required this.isDone});

  late bool isDone;

  @override
  State<LoginCongratsCard> createState() => _LoginCongratsCardState();
}

class _LoginCongratsCardState extends State<LoginCongratsCard> {
  @override
  Widget build(BuildContext context) {
    bool isDone = false;
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardContent extends StatefulWidget {
  const CardContent({super.key, required this.isDone});

  final bool isDone;

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

  //
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   animationController.dispose();
  // }

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
        const SizedBox(height: 40),
        ScaleTransition(
          scale: CurvedAnimation(
              parent: animationController, curve: Curves.elasticOut),
          child:
          // ImageIcon(AssetImage(Assets.GIFT_ICON),color: AppColors.secondaryButtonColor,size: 25,)
          const Text(
            "🎉",
            style: TextStyle(fontSize: 50),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Congratulation",
          style: theme.textTheme.headlineLarge?.copyWith(fontSize: 30),
        ),
        const SizedBox(height: 90),
      ],
    );
  }
}
