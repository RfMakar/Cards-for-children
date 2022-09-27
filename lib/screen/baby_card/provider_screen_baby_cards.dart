import 'package:busycards/data/db_baby_cards.dart';
import 'package:busycards/model/baby_card.dart';
import 'package:flutter/foundation.dart';

class ProviderScreenBabyCard extends ChangeNotifier {
  Future<List<BabyCard>> list() async {
    return await DBBabyCards.getListCards();
  }
}
