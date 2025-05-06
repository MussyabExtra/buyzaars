import '../../../../utilities/colors.dart';
import 'package:flutter/material.dart';

class CustomTabPageSelector extends StatelessWidget {
  final TabController controller;

  const CustomTabPageSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(controller.length, (int index) {
          return AnimatedBuilder(
            animation: controller.animation!,
            builder: (BuildContext context, Widget? child) {
              final bool selected = controller.index == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                width: selected ? 30.0 : 12.0,
                height: 12.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: selected ? AppColor.red : Colors.white,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
