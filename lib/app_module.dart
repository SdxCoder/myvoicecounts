import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/features/splash_screen/views/splash_view.dart';
import 'package:myvoicecounts/main.dart';
import './features/settings/settings_module.dart';
import 'features/home/home.dart';
import './features/splash_screen/splash_module.dart';
import 'features/splash_screen/services/splash_service.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
     Bind((i) => SplashService())
  ];

  @override
  List<Router> get routers => [
        Router('/', module: SplashModule()),
        Router('/home', child: (_, args) => HomeView()),
        Router('/settings', module: SettingsModule()),
      ];

  @override
  Widget get bootstrap => App();
}
