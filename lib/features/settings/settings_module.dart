

import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/features/settings/presentation/views/settings_view.dart';

import 'services/settings_service.dart';

class SettingsModule extends ChildModule{
  @override
  List<Bind> get binds => [
     Bind((i) => SettingsService())
  ];

  @override
  List<Router> get routers => [
    Router('/settings', child: (_, args) => SettingsView())
  ];

  static Inject get to => Inject<SettingsModule>.of();

}