import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'PreferencesStore.g.dart';

class PreferencesStore extends _PreferencesStore with _$PreferencesStore {
  static PreferencesStore _instance;

  factory PreferencesStore() {
    if (_instance == null) _instance = PreferencesStore._();

    return _instance;
  }

  PreferencesStore._() {
    SharedPreferences.getInstance().then((prefs) {
      this.firstRun = prefs.getBool("firstRun") ?? true;
    });
  }
}

abstract class _PreferencesStore with Store {
  @observable
  bool firstRun;

  @action
  Future<void> setFirstRun(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("firstRun", value);
    firstRun = value;
  }
}
