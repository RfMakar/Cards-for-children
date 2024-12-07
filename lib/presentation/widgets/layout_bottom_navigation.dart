import 'package:flutter/widgets.dart';

class LayoutButtomNavigation extends StatelessWidget {
  const LayoutButtomNavigation({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return switch (orientation) {
      Orientation.portrait => _portrait(),
      Orientation.landscape => _landscape(),
    };
  }

  Widget _portrait() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }

  Widget _landscape() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children.reversed.toList(),
        ),
      ),
    );
  }
}
