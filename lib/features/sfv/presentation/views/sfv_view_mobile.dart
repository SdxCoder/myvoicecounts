import 'package:flutter/material.dart';
import 'package:myvoicecounts/core/core.dart';

import 'package:responsive_builder/responsive_builder.dart';
import '../widgets/video_player.dart';

class SettingsViewMobile extends StatefulWidget {
  @override
  _SettingsViewMobileState createState() => _SettingsViewMobileState();
}

class _SettingsViewMobileState extends State<SettingsViewMobile> {
  List<Widget> wds = [];

  @override
  void initState() {
    super.initState();
    wds.add(Text("sss"));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => ScaffoldMobile(
        title: Text("How I Self-Identify"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            children: <Widget>[
              Text(
                "Video Title",
                style: themeData.textTheme.body1.copyWith(
                    color: Colors.black54,
                    fontSize: sizingInfo.screenSize.width * 0.08),
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                height: 0,
              ),
              VideoApp()
             
            ],
          ),
        ),
      ),
    );
  }
}
