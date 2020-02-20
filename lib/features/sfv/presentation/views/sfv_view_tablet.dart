import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';

import 'package:responsive_builder/responsive_builder.dart';
import '../widgets/video_player.dart';

class SfvViewTablet extends StatefulWidget {
  @override
  _SfvViewTabletState createState() => _SfvViewTabletState();
}

class _SfvViewTabletState extends State<SfvViewTablet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => ScaffoldTablet(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32),
          child: _sfvList(context, sizingInfo),
        ),
      ),
    );
  }
}

Widget _sfvList(BuildContext context, SizingInformation sizingInfo) {
  return ListView.builder(
    physics: BouncingScrollPhysics(),
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return VideoApp(
                  url:
                      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
                  sizingInfo: sizingInfo,
                );
              }));
            },
            child: Row(
              children: <Widget>[
                Container(
                  height: sizingInfo.screenSize.height * 0.4,
                  width: sizingInfo.screenSize.width * 0.4,
                  child: Image.asset('images/thumbnail.png'),
                ),
                SizedBox(
                  width: sizingInfo.screenSize.width * 0.05,
                ),
                Text(
                  "Video Title",
                  style: themeData.textTheme.body1.copyWith(
                      color: Colors.black54,
                      fontSize: sizingInfo.screenSize.height * 0.04),
                ),
              ],
            ),
          ),
          SizedBox(height: sizingInfo.screenSize.height * 0.00),
        ],
      );
    },
  );
}
