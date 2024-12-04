import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/config/UI/app_text_style.dart';
import 'package:busycards/config/router/router_path.dart';
import 'package:busycards/core/objects/parental_control.dart';
import 'package:busycards/presentation/widgets/app_button.dart';
import 'package:busycards/presentation/widgets/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ParentalControlScreen extends StatelessWidget {
  const ParentalControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ParentalControl(),
      child: const LayoutScreen(
        body: BodyParentalControl(),
        navigation: ButtomNavigation(),
      ),
    );
  }
}

class BodyParentalControl extends StatelessWidget {
  const BodyParentalControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TopWidget(),
        ExampleWidget(),
        AnswerWidget(),
      ],
    );
  }
}

class TopWidget extends StatelessWidget {
  const TopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Родительский контроль',
        style: AppTextStyle.textStyle,
      ),
    );
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final parentalControl = context.read<ParentalControl>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            parentalControl.textExample,
            style: AppTextStyle.textStyle,
          ),
        ],
      ),
    );
  }
}

class AnswerWidget extends StatelessWidget {
  const AnswerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final parentalControl = context.read<ParentalControl>();
    return SizedBox(
      width: 150,
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: AppTextStyle.textStyle,
        cursorColor: AppColor.white,
        onChanged: (val) {
          if (val.isEmpty) {
            return;
          }
          final sum = int.parse(val);
          final isResult = parentalControl.checkingTheAmount(sum);
          if (isResult) {
            final location =
                '${RouterPath.pathHomeScreen}/${RouterPath.pathParentalControlScreen}/${RouterPath.pathSettingsScreen}';
            context.replace(location);
          }
        },
        decoration: InputDecoration(
          hintText: 'Ответ',
          hintStyle: AppTextStyle.textStyle,
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: AppColor.white,
              ),
              borderRadius: BorderRadius.circular(16)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
                color: AppColor.white,
              ),
              borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}

class ButtomNavigation extends StatelessWidget {
  const ButtomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppButton.home(
              onTap: context.pop,
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
