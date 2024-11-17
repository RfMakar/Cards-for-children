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
  final radius = 16.0;
  final borderWidht = 2.0;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: EdgeInsets.zero,
      onPressed: null,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        splashColor: Color(babyCard.color),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColor.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: Color(babyCard.color),
              width: borderWidht,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  babyCard.icon,
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(babyCard.color),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius - borderWidht),
                    bottomRight: Radius.circular(radius - borderWidht),
                  ),
                  color: Color(babyCard.color),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    babyCard.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    softWrap: true,
                    style: const TextStyle(
                      color: AppColor.white,
                      //fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
