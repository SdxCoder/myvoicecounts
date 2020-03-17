

import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/sfv/data/sfv_model.dart';
import 'package:myvoicecounts/features/sfv/presentation/view_models/sfv_view_model.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PlaySfvWidget extends StatelessWidget {
  final Sfv sfv;

  const PlaySfvWidget({Key key, this.sfv}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: ResponsiveBuilder(
        builder: (context,sizingInfo)=>
             Column(
          children: <Widget>[
             Padding(
                          padding: (MediaQuery.of(context).orientation ==
                                Orientation.landscape) ? EdgeInsetsDirectional.only(top : 0) : EdgeInsetsDirectional.only(top : 24),
                          child: AwsomeVideoPlayer(

                            sfv.link,
                            playOptions: VideoPlayOptions(
                                seekSeconds: 30,
                                aspectRatio: 16 / 9,
                                loop: false,
                                autoplay: true,
                                allowScrubbing: true,
                                startPosition: Duration(seconds: 0)),
                            videoStyle: VideoStyle(
                              playIcon: Icon(
                                Icons.play_arrow,
                                size: (sizingInfo.deviceScreenType == DeviceScreenType.Tablet) ? 72 : 48,
                                color: Colors.white,
                              ),
                              showPlayIcon: true,
                              videoTopBarStyle: VideoTopBarStyle(
                                popIcon: Icon(Icons.arrow_back, size: (sizingInfo.deviceScreenType == DeviceScreenType.Tablet) ? 24 : 16),
                                height: (sizingInfo.deviceScreenType == DeviceScreenType.Tablet) ? 60 : 40,
                              ),
                              videoControlBarStyle: VideoControlBarStyle(
                                height: (sizingInfo.deviceScreenType == DeviceScreenType.Tablet) ? 60 : 40,
                                progressStyle: VideoProgressStyle(
                                    playedColor: themeData.primaryColor,
                                    bufferedColor: themeData.accentColor,
                                    backgroundColor: Colors.white,
                                    dragBarColor: Colors.white,
                                    height: 4,
                                    progressRadius: (sizingInfo.deviceScreenType == DeviceScreenType.Tablet) ? 8 : 4,
                                    dragHeight: (sizingInfo.deviceScreenType == DeviceScreenType.Tablet) ? 8 : 5,),
                                playIcon: Icon(Icons.play_arrow,
                                    color: Colors.white, size:(sizingInfo.deviceScreenType == DeviceScreenType.Tablet) ? 48 : 20,
                                    ),
                                pauseIcon: Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                  size: (sizingInfo.deviceScreenType == DeviceScreenType.Tablet) ? 48 : 20,
                                ),
                                rewindIcon: Icon(
                                  Icons.replay_30,
                                  size: (sizingInfo.deviceScreenType == DeviceScreenType.Tablet) ? 48 : 20,
                                  color: Colors.white,
                                ),
                                forwardIcon: Icon(
                                  Icons.forward_30,
                                  size: (sizingInfo.deviceScreenType == DeviceScreenType.Tablet) ? 48 : 20,
                                  color: Colors.white,
                                ),
                                fullscreenIcon: Icon(
                                  Icons.fullscreen,
                                  size: (sizingInfo.deviceScreenType == DeviceScreenType.Tablet) ? 48 : 20,
                                  color: Colors.white,
                                ),
                                fullscreenExitIcon: Icon(
                                  Icons.fullscreen_exit,
                                  size: (sizingInfo.deviceScreenType == DeviceScreenType.Tablet) ? 48 : 20,
                                  color: Colors.white,
                                ),
                                itemList: [
                                  "rewind",
                                  "play",
                                  "forward",
                                  "position-time",
                                  "progress",
                                  "duration-time",
                                  "fullscreen"
                                ],
                              ),
                            ),
                            children: [],
                            oninit: (val) {
                            
                              
                              print("video oninit ${val.dataSource}");
                            },
                            onfullscreen: (bool){
                              
                            },
                            onplay: (value) {
                              print("video played");
                            },
                            onpause: (value) {
                              print("video paused");
                            },
                            onended: (value) {
                              print("video ended");
                            },
                            ontimeupdate: (value) {
                              print("timeupdate $value");
                              var position = value.position.inMilliseconds / 1000;
                            },
                            onvolume: (value) {
                              print("onvolume $value");
                            },
                            onbrightness: (value) {
                              print("onbrightness $value");
                            },
                            onnetwork: (value) {
                              if(value == "none"){
                                // showSnackBarInfo(
                                //   desc: "No Network"
                                // );
                              }
                              print("onNetwork $value");
                            },
                            onpop: (value) {
                              Modular.to.pop();
                            },
                          ),
                        ),
                        (
                        MediaQuery.of(context).orientation ==
                                Orientation.landscape && sizingInfo.deviceScreenType == DeviceScreenType.Tablet)
                           
                            ? Offstage()
                            : Container(
                                // height: 70,
                                alignment: Alignment.centerLeft,
                                color: themeData.primaryColor.withOpacity(0.1),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        sfv.title,
                                        style: themeData.textTheme.body1.copyWith(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          InkWell(
                                              onTap: () {},
                                              child: Icon(
                                                FontAwesomeIcons.thumbsUp,
                                                color: Colors.green,
                                                size: (sizingInfo.screenSize.width <
                                                        400)
                                                    ? 24
                                                    : 32,
                                              )),
                                          SizedBox(width: 8),
                                          InkWell(
                                              onTap: () {},
                                              child: Icon(
                                                FontAwesomeIcons.thumbsDown,
                                                color: Colors.red,
                                                size: (sizingInfo.screenSize.width <
                                                        400)
                                                    ? 24
                                                    : 32,
                                              )),
                                          SizedBox(width: 8),
                                          InkWell(
                                            onTap: () {},
                                            child: Icon(
                                              FontAwesomeIcons.timesCircle,
                                              color: Colors.grey,
                                              size: (sizingInfo.screenSize.width <
                                                      400)
                                                  ? 24
                                                  : 32,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
          ],
        ),
      ),
    );
  }
}