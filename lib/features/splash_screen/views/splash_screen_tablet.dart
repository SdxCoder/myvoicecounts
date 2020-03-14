


import 'package:flutter/material.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SplashScreenTablet extends StatelessWidget {
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
                    image: DecorationImage(
                        image: AssetImage('images/mvc_logo.png')),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            
            Text('Welcome to', style: Theme.of(context).textTheme.bodyText1.copyWith(color:Colors.white54)),
            SizedBox(height: 10,),
            Text('OPINION/8ED', style: Theme.of(context).textTheme.display1.copyWith(color:Colors.white70, fontWeight: FontWeight.bold)),
           SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child: Container(
                width: sizingInfo.screenSize.width * 0.7,
                //padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white54,
                      width: 0.2,
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                    child: Container(
                  width: sizingInfo.screenSize.width,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text(
                      "Agree? Disagree? Undecided",
                      style: themeData.textTheme.bodyText1.copyWith(
                          color: Colors.white70, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
              ),
            ),
            Text('How people feel on issues\nand personalities. Open to all',
                textAlign: TextAlign.center,
                style: themeData.textTheme.bodyText1.copyWith(color:Colors.white54)),
           ],
        )),
      );
    });
  }
}
