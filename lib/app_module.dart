import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/features/people/services/candidate_service.dart';
import 'package:myvoicecounts/features/settings/services/settings_service.dart';
import 'package:myvoicecounts/features/settings/settings.dart';
import 'package:myvoicecounts/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/core.dart';
import 'core/routes/paths.dart';
import 'features/data/data.dart';
import 'features/data_by_candidate/data_cadidate.dart';
import 'features/home/home.dart';
import './features/splash_screen/splash_module.dart';
import 'features/issues/issues.dart';
import 'features/issues/services/issues_service.dart';
import 'features/people/people.dart';
import 'features/sfv/sfv.dart';
import 'features/splash_screen/services/splash_service.dart';
import 'features/splash_screen/views/splash_view.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SplashService()),
        Bind((i) => SettingsService()),
        Bind((i) => CandidateService()),
        Bind((i) => IssuesService()),
        Bind((i) => SfvService()),
        //Bind((i)  async => SharedPrefs(await SharedPreferences.getInstance()), singleton: true)
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => SplashView()),
        Router(Paths.home, child: (_, args) => HomeView()),
        Router(Paths.settings, child: (_, args) => SettingsView()),
        Router(Paths.people, child: (_, args) => PeopleView()),
        Router(Paths.issues, child: (_, args) => IssueView()),
        Router(Paths.dataByIssue,
            child: (_, args) => DataView(issue: args.data)),
        Router(Paths.dataByPersonality,
            child: (_, args) => DataCandidateView(candidate: args.data)),
        Router(Paths.sfv, child: (_, args) => SfvView()),
      ];

  @override
  Widget get bootstrap => App();
}
