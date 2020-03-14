

import 'package:flutter_modular/flutter_modular.dart';
import '../../core/core.dart';
import 'data_cadidate.dart';

class DataCandidateModule extends ChildModule{
  @override
  List<Bind> get binds => [
     
  ];

  @override
  List<Router> get routers => [
    Router(Paths.dataByPersonality, child: (_, args) => DataCandidateView())
  ];

  static Inject get to => Inject<DataCandidateModule>.of();

}