import 'package:busycards/data/db_baby_cards.dart';
import 'package:busycards/model/baby_card.dart';
import 'package:busycards/screen/game/alphabet/provider_card_alphabet.dart';
import 'package:busycards/widget/style_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenAlphabetGame extends StatelessWidget {
  const ScreenAlphabetGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Алфавит', style: TextApp.appBar),
        backgroundColor: ColorsApp.menuGame,
      ),
      backgroundColor: ColorsApp.backgroundMenuGame,
      body: const ListGame(),
    );
  }
}

class ListGame extends StatelessWidget {
  const ListGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BabyCard>>(
      future: DBBabyCards.getListBabyCards(13),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }
        final listCardAlphabet = snapshot.data!;
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
          itemCount: listCardAlphabet.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
          ),
          itemBuilder: (context, index) {
            return CardAlphabet(babyCard: listCardAlphabet[index]);
          },
        );
      },
    );
  }
}

class CardAlphabet extends StatelessWidget {
  const CardAlphabet({Key? key, required this.babyCard}) : super(key: key);
  final BabyCard babyCard;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderCardAlphabet(babyCard),
      child: Consumer<ProviderCardAlphabet>(
        builder: (_, model, __) {
          return Card(
            child: InkWell(
              onTap: model.onTapCard,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.asset(
                    model.path,
                    fit: BoxFit.cover,
                  )),
            ),
          );
        },
      ),
    );
  }
}
