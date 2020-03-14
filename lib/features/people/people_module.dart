

import 'package:flutter_modular/flutter_modular.dart';
import '../../core/core.dart';
import 'presentation/views/people_view.dart';

class PeopleModule extends ChildModule{
  @override
  List<Bind> get binds => [
     
  ];

  @override
  List<Router> get routers => [
    Router(Paths.people, child: (_, args) => PeopleView())
  ];

  static Inject get to => Inject<PeopleModule>.of();

}