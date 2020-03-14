

import 'package:flutter_modular/flutter_modular.dart';
import '../../core/core.dart';
import 'data.dart';

class DataModule extends ChildModule{
  @override
  List<Bind> get binds => [
     
  ];

  @override
  List<Router> get routers => [
    Router(Paths.dataByIssue, child: (_, args) => DataView())
  ];

  static Inject get to => Inject<DataModule>.of();

}