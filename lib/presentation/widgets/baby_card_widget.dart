import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/domain/entities/baby_card.dart';
import 'package:flutter/material.dart';

class BabyCardWidget extends StatelessWidget {
  const BabyCardWidget({
    super.key,
    required this.babyCard,
    required this.onTap,
  });
  final BabyCard babyCard;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: EdgeInsets.zero,
      onPressed: null,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: Color(babyCard.color),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColor.color2,
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            border: Border.all(
              color: Color(babyCard.color),
              width: 3,
            ),
          ),
          child: Center(
            child: Image.asset(babyCard.icon),
          ),
        ),
      ),
    );
  }
}
