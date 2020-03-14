

import 'package:flutter_modular/flutter_modular.dart';
import '../../core/core.dart';
import 'presentation/views/issues_view.dart';

class IssuesModule extends ChildModule{
  @override
  List<Bind> get binds => [
     
  ];

  @override
  List<Router> get routers => [
    Router(Paths.issues, child: (_, args) => IssueView())
  ];

  static Inject get to => Inject<IssuesModule>.of();

}