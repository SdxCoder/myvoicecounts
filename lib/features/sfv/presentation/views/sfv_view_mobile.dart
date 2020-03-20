import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/sfv/presentation/view_models/sfv_view_model.dart';
import 'package:myvoicecounts/features/sfv/presentation/widgets/awesom_video_player.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SfvViewMobile extends StatelessWidget {
  final SfvViewModel model;

  SfvViewMobile({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldMobile(
      title: Text("Videos", style: themeData.textTheme.body1,),
          body: ResponsiveBuilder(
        builder: (context, sizingInfo) => (model.buzy)
            ? Center(child: CircularProgressIndicator())
            : (model.sfvList.isEmpty)
                ? Center(child: Text("No Sfvs"))
                : Column(
                    children: <Widget>[
                       Expanded(child: _buildSfvsList(model, sizingInfo)),
                     
                     
                    ],
                  ),
      ),
    );
  }

  Widget _buildSfvsList(SfvViewModel model,SizingInformation sizingInfo) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: model.sfvList.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: themeData.primaryColor.withOpacity(0.1),
                maxRadius: 30,
                child: Icon(Icons.play_arrow, color: themeData.primaryColor,)),
              title: Text(model.sfvList[index].title),
              onTap: () {
              
             //  Modular.to.pushNamed("player", arguments: model);
               Navigator.push(context, MaterialPageRoute(
                 builder: (context) => PlaySfvWidget(model : model, sfv : model.sfvList[index])
               ));
               
              },
            ),
            Divider()
          ],
        );
      },
    );
  }
}
