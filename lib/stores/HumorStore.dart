import 'package:mobx/mobx.dart';
import '../models/Humor.dart';

part 'HumorStore.g.dart';

enum HumorStoreStatus { idle, busy, done }

class HumorStore extends _HumorStore with _$HumorStore {
  static HumorStore instance = HumorStore();
}

abstract class _HumorStore with Store {
  @observable
  ObservableList<RegistroHumor> humorList;

  @action
  Future<void> addHumor(RegistroHumor humor) {
    humorList.add(humor);
  }
}
