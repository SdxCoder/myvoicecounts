

import 'package:flutter_modular/flutter_modular.dart';
import '../../core/core.dart';
import 'home.dart';
import 'services/home_service.dart';

class HomeModule extends ChildModule{
  @override
  List<Bind> get binds => [
      Bind((i) => HomeService())
  ];

  @override
  List<Router> get routers => [
    Router(Paths.home, child: (_, args) => HomeView())
  ];

  static Inject get to => Inject<HomeModule>.of();

}