import 'package:busycards/data/db_menu.dart';
import 'package:busycards/model/menu.dart';
import 'package:busycards/screen/cards/screen_cards.dart';
import 'package:busycards/widget/style_app.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ScreenMenuCards extends StatelessWidget {
  const ScreenMenuCards({Key? key, required this.menu}) : super(key: key);
  final Menu menu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menu.name, style: TextApp.appBar),
        backgroundColor: ColorsApp.menuCards,
      ),
      backgroundColor: ColorsApp.backgroundMenuCards,
      body: const ListMenuCards(),
    );
  }
}

class ListMenuCards extends StatelessWidget {
  const ListMenuCards({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Menu>>(
      future: DBMenu.getListMenuCards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }
        final listMenuCards = snapshot.data!;
        return GridView.builder(
          padding: const EdgeInsets.all(4),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: listMenuCards.length,
          itemBuilder: (context, index) {
            return WidgetMenuCard(menu: listMenuCards[index]);
          },
        );
      },
    );
  }
}

class WidgetMenuCard extends StatefulWidget {
  const WidgetMenuCard({Key? key, required this.menu}) : super(key: key);
  final Menu menu;

  @override
  State<WidgetMenuCard> createState() => _WidgetMenuCardState();
}

class _WidgetMenuCardState extends State<WidgetMenuCard> {
  final audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.menu.audio != null) {
          audioPlayer.setAsset(widget.menu.audio!);
          audioPlayer.play();
        }
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScreenCards(menu: widget.menu)),
        );
      },
      child: Card(
        color: ColorsApp.menuCards,
        child: Column(
          children: [
            Expanded(child: Image.asset(widget.menu.icon)),
            Text(widget.menu.name,
                style: TextApp.primary,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
