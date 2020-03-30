import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/sfv/presentation/view_models/sfv_view_model.dart';
import 'package:myvoicecounts/features/sfv/presentation/widgets/youtube_player.dart';

import 'package:responsive_builder/responsive_builder.dart';


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
                ? Center(child: Text("No Videos today.\n\nPlease check again later"))
                : Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        "Videos",
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
              leading:Container(
                height: 60,
                width: 100,
                
                decoration: BoxDecoration(
                  
                  borderRadius : BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/bernie.jpg')
                  ),
                  color: Colors.red
                ),
               child: Icon(Icons.play_arrow, color: Colors.white, size: 24,),
              ),
              title: Text(model.sfvList[index].title),
              onTap: () {
               // Modular.to.pushNamed("player", arguments: model.sfvList[index]);
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
