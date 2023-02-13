import 'package:busycards/model/menu.dart';
import 'package:busycards/model/raw.dart';
import 'package:busycards/screen/raw/provider_screen_raw.dart';
import 'package:busycards/widget/style_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenRaw extends StatelessWidget {
  const ScreenRaw({Key? key, required this.menu}) : super(key: key);
  final Menu menu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menu.name, style: TextApp.appBar),
        backgroundColor: ColorsApp.menuRaw,
      ),
      backgroundColor: ColorsApp.backgroundMenuRaw,
      body: const ListRaw(),
    );
  }
}

class ListRaw extends StatelessWidget {
  const ListRaw({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenRaw(),
      child: Consumer<ProviderScreenRaw>(
        builder: (_, model, __) {
          return FutureBuilder<List<Raw>>(
            future: model.getListRaw(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
              final listRaw = snapshot.data!;
              return Column(
                children: [
                  TableRaw(listRaw: listRaw),
                  const ButtonSync(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class TableRaw extends StatelessWidget {
  const TableRaw({Key? key, required this.listRaw}) : super(key: key);
  final List<Raw> listRaw;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProviderScreenRaw>();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: model.color, width: 8),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: FittedBox(
            child: Column(children: [
              Row(
                children: [
                  CardRaw(raw: listRaw[0]),
                  CardRaw(raw: listRaw[1]),
                  CardRaw(raw: listRaw[2]),
                ],
              ),
              Row(
                children: [
                  CardRaw(raw: listRaw[3]),
                  CardRaw(raw: listRaw[4]),
                  CardRaw(raw: listRaw[5]),
                ],
              ),
              Row(
                children: [
                  CardRaw(raw: listRaw[6]),
                  CardRaw(raw: listRaw[7]),
                  CardRaw(raw: listRaw[8]),
                ],
              ),
              Row(
                children: [
                  CardRaw(raw: listRaw[9]),
                  CardRaw(raw: listRaw[10]),
                  CardRaw(raw: listRaw[11]),
                ],
              ),
            ]),
          ),
        )),
      ),
    );
  }
}

class CardRaw extends StatelessWidget {
  const CardRaw({Key? key, required this.raw}) : super(key: key);
  final Raw raw;
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProviderScreenRaw>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            minimumSize: const Size.square(180),
            primary: model.color,
          ),
          onPressed: () => model.onPressedButtonRaw(raw),
          child: null),
    );
  }
}

class ButtonSync extends StatelessWidget {
  const ButtonSync({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProviderScreenRaw>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            shape: const StadiumBorder(
                side: BorderSide(color: ColorsApp.secondary, width: 2)),
            backgroundColor: model.color,
            onPressed: model.onPressedButtomSync,
            child: const Icon(Icons.sync_sharp),
          ),
        ),
      ],
    );
  }
}
