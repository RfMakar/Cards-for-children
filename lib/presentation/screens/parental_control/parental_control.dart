import 'package:busycards/config/UI/app_color.dart';
import 'package:busycards/config/UI/app_text_style.dart';
import 'package:busycards/core/functions/setup_dependencies.dart';
import 'package:busycards/presentation/screens/parental_control/parental_control_store.dart';
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
      create: (context) => sl<ParentalControlStore>(),
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
    final store = context.read<ParentalControlStore>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            store.textSum,
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
    final store = context.read<ParentalControlStore>();
    return SizedBox(
      width: 150,
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: AppTextStyle.textStyle,
        cursorColor: AppColor.white,
        onChanged: (val) {
          if (store.resultSum(val)) {
            context.replace('/home/parental_control/settings');
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
