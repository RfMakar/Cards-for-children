import 'package:busycards/data/db_baby_cards.dart';
import 'package:busycards/model/baby_card.dart';
import 'package:busycards/widget/style_app.dart';
import 'package:flutter/material.dart';

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

class CardAlphabet extends StatefulWidget {
  const CardAlphabet({Key? key, required this.babyCard}) : super(key: key);

  final BabyCard babyCard;

  @override
  State<CardAlphabet> createState() => _CardAlphabetState();
}

class _CardAlphabetState extends State<CardAlphabet> {
  late String path;
  var click = 0;
  @override
  void initState() {
    path = widget.babyCard.icon;
    super.initState();
  }

  void onTap() {
    if (click == 0) {
      path = widget.babyCard.image;
      click = 1;
    } else {
      path = widget.babyCard.icon;
      click = 0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
            child: Image.asset(
          path,
          fit: BoxFit.cover,
        )),
      ),
    );
  }
}
