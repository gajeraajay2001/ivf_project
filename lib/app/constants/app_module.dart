import 'package:ivf_project/app/utilities/connectivity_service.dart';
import 'package:ivf_project/app/utilities/progress_dialog_utils.dart';
import 'package:kiwi/kiwi.dart';
part "app_module.g.dart";

abstract class AppModule {
  @Register.singleton(ConnectivityService)
  @Register.singleton(CustomDialogs)
  void configure();
}

void setup() {
  var appModule = _$AppModule();
  appModule.configure();
}
