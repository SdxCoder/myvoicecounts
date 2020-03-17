import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/sfv/presentation/view_models/sfv_view_model.dart';

import 'package:responsive_builder/responsive_builder.dart';
import '../widgets/video_player.dart';

class SfvViewTablet extends StatelessWidget {
  final SfvViewModel model;

  const SfvViewTablet({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => ScaffoldTablet(
        body: (model.buzy)
            ? Center(child: CircularProgressIndicator())
            : (model.sfvList.isEmpty)
                ? Center(child: Text("No Sfvs"))
                : Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        "SFVs",
                        style: themeData.textTheme.body1.copyWith(
                          color: Colors.grey,
                          fontSize: headlineSize(sizingInfo)
                        ),
                      ),
                      Expanded(child: _buildSfvsList(model, sizingInfo)),
                    ],
                  ),
      ),
    );
  }

  Widget _buildSfvsList(SfvViewModel model, SizingInformation sizingInfo) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: model.sfvList.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: themeData.primaryColor.withOpacity(0.1),
                  maxRadius: 50,
                  child: Icon(
                    Icons.play_arrow,
                    color: themeData.primaryColor,
                  )),
              title: Text(model.sfvList[index].title),
              onTap: () {
                Modular.to.pushNamed("player", arguments: model.sfvList[index]);
              },
            ),
            Divider()
          ],
        );
      },
    );
  }
}
