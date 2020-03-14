

import 'package:flutter_modular/flutter_modular.dart';
import '../../core/core.dart';
import 'sfv.dart';

class SfvModule extends ChildModule{
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
    Router(Paths.dataByIssue, child: (_, args) => SfvView())
  ];

  static Inject get to => Inject<SfvModule>.of();

}