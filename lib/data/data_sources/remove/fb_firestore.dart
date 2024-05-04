import 'package:busycards/data/model/category_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FBFireStore {
  final FirebaseFirestore _firebaseFirestore;
  late CollectionReference<CategoryCardModel> _collectionReference;

  FBFireStore({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore {
    _collectionReference =
        _firebaseFirestore.collection('category').withConverter(
              fromFirestore: CategoryCardModel.fromFirestore,
              toFirestore: (CategoryCardModel categoryCardModel, _) =>
                  categoryCardModel.toFirestore(),
            );
  }

  Future<List<CategoryCardModel>> getCategoriesCards() async {
    final querySnapshot = await _collectionReference.get();
    return _getListObject(querySnapshot);
  }

  List<T> _getListObject<T>(QuerySnapshot<T> querySnapshot) {
    final list = <T>[];
    for (var element in querySnapshot.docs) {
      list.add(element.data());
    }
    return list;
  }
}
