import 'package:flutter/material.dart';
import 'package:lets_collect/src/ui/home/components/widgets/custom_scroll_view_widget.dart';

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
        // LoginCongratsCard(
        //   isDone: isDone,
        //   emailVerifiedPoints: emailVerifiedPoints,
        // )
      ],
    );
  }
}
