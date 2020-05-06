import 'package:afetivo/models/Medicamento.dart';
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
  RegistroHumor createHumor(TipoHumor tipoHumor) {
    final humor = RegistroHumor(tipo: tipoHumor);
    if (loginStore != null && loginStore.userProfile != null) {
      humor.medicamentos = ObservableList.of(loginStore.userProfile.medicamentos
          .map((med) => RegistroMedicamento(medicamento: med))
          .toList());
    }

    return humor;
  }

  @action
  Future<void> editHumor(RegistroHumor humor) async {
    await Future.delayed(Duration(seconds: 1));
    humorList.removeWhere((item) => item.id == humor.id);
    humorList.add(humor);
    humorList.sort((a, b) => b.data.compareTo(a.data));
  }

  @action
  Future<void> deleteHumor(RegistroHumor humor) async {
    await Future.delayed(Duration(seconds: 1));
    humorList.remove(humor);
  }
}
