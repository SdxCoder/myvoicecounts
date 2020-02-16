import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import './people_view_mobile.dart';
import './people_view_tablet.dart';



class PeopleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: ScreenTypeLayout.builder(
        mobile: (context) => PeopleViewMobile(),
        tablet: (context) => PeopleViewTablet(),
      ),
    );
  }
}