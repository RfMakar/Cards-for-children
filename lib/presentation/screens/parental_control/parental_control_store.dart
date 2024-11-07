import 'package:busycards/domain/entities/parental_control.dart';
import 'package:mobx/mobx.dart';

part 'parental_control_store.g.dart';

// ignore: library_private_types_in_public_api
class ParentalControlStore = _ParentalControlStore with _$ParentalControlStore;

abstract class _ParentalControlStore with Store {
  _ParentalControlStore({required ParentalControl parentalControl})
      : _parentalControl = parentalControl;
  final ParentalControl _parentalControl;
  late String textSum;

  Future<void> init() async {
    textSum = '${_parentalControl.a} + ${_parentalControl.b} = ?';
  }

  bool resultSum(String val) {
    if (val.isEmpty) {
      return false;
    } else {
      return _parentalControl.checkingTheAmount(int.parse(val));
    }
  }
}
