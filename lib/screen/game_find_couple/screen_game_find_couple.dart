import 'package:busycards/model/baby_card.dart';
import 'package:busycards/screen/game_find_couple/provider_screen_game_find_couple.dart';
import 'package:busycards/screen/widget/button_navigator_back.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenGameFindCouple extends StatelessWidget {
  const ScreenGameFindCouple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ListBabyCards(),
    );
  }
}

class ListBabyCards extends StatelessWidget {
  const ListBabyCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProviderScreenGameFindCouple(),
        child: Consumer<ProviderScreenGameFindCouple>(
          builder: (_, model, __) {
            return FutureBuilder<Map<int, BabyCard>>(
                future: model.listCard,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final listBabyCards = snapshot.data!;
                  return Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      GridView.builder(
                          padding: const EdgeInsets.all(4.0),
                          shrinkWrap: true,
                          itemCount: listBabyCards.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            //mainAxisExtent: 140,
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            var babyCard = listBabyCards[index]!;
                            return Card(
                              color: model.colorCard[index],
                              child: InkWell(
                                onTap: model.pressedCard[index]
                                    ? () => model.onClick(index, babyCard)
                                    : null,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: Image.asset(babyCard.iconbutton),
                                ),
                              ),
                            );
                          }),
                      Column(
                        verticalDirection: VerticalDirection.up,
                        children: [
                          SizedBox(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                ButtonNavigatorBack(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                });
          },
        ));
  }
}
