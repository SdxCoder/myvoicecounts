import 'package:flutter/material.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SplashScreenMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      return Container(
        decoration: BoxDecoration(gradient: gradient3),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
              child: Container(
                height: sizingInfo.screenSize.width * 0.5,
                width: sizingInfo.screenSize.width * 0.5,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(hexColor('f2f2f2')),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
              ),
            ),
            Text('Welcome to', style: Theme.of(context).textTheme.body1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
              child: Container(
                width: sizingInfo.screenSize.width * 0.7,
                decoration: BoxDecoration(
                    color: themeData.accentColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 32),
                  child: Text(
                    "MyVoiceCounts",
                    style: themeData.textTheme.display3
                        .copyWith(color: themeData.primaryColorDark),
                  ),
                )
                ),
              ),
            ),
            Text('A live sentiment map of how',style: themeData.textTheme.body1 ),
            Text('Constituents Feel', style: themeData.textTheme.body1.copyWith(color : themeData.accentColor))

          ],
        )),
      );
    });
  }
}
