import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_collect/src/bloc/home_bloc/home_bloc.dart';
import 'package:lets_collect/src/ui/home/components/widgets/custom_scroll_view_widget.dart';
import 'package:lets_collect/src/ui/home/components/widgets/email_verified_alert_overlay.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'alert_overlay_widget.dart';
import 'login_congrats_card.dart';

class HomeScreenNavigation extends StatefulWidget {
  final Function(int) onIndexChanged;

  const HomeScreenNavigation({super.key, required this.onIndexChanged});

  @override
  State<HomeScreenNavigation> createState() => _HomeScreenNavigationState();
}

class _HomeScreenNavigationState extends State<HomeScreenNavigation> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollViewWidget(
          onIndexChanged: (index) {
            widget.onIndexChanged(index);
          },
        ),
      ],
    );
  }
}
