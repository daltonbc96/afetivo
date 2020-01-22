import 'package:afetivo/stores/LoginStore.dart';
import 'package:mobx/mobx.dart';
import '../models/Humor.dart';

part 'HumorStore.g.dart';

class HumorStore = _HumorStore with _$HumorStore;

abstract class _HumorStore with Store {
  LoginStore loginStore;

  _HumorStore({this.loginStore});

  @observable
  ObservableList<RegistroHumor> humorList = ObservableList();

  @action
  Future<void> addHumor(RegistroHumor humor) async {
    await Future.delayed(Duration(seconds: 1));
    humorList.add(humor);
    humorList.sort((a, b) => b.data.compareTo(a.data));
  }

  @action
  Future<void> deleteHumor(RegistroHumor humor) async {
    await Future.delayed(Duration(seconds: 1));
    humorList.remove(humor);
  }
}
