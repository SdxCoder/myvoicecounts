import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/sfv/presentation/view_models/sfv_view_model.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SfvViewMobile extends StatelessWidget {
  final SfvViewModel model;

  SfvViewMobile({Key key, this.model}) : super(key: key);

  var _controller;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => (model.buzy)
          ? Center(child: CircularProgressIndicator())
          : (model.sfvList.isEmpty)
              ? Center(child: Text("No Sfvs"))
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: (MediaQuery.of(context).orientation ==
                            Orientation.landscape) ? EdgeInsetsDirectional.only(top : 0) : EdgeInsetsDirectional.only(top : 24),
                      child: AwsomeVideoPlayer(

                        model.selectedSfv.link,
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
                            size: 48,
                            color: Colors.white,
                          ),
                          showPlayIcon: true,
                          videoControlBarStyle: VideoControlBarStyle(
                            progressStyle: VideoProgressStyle(
                                playedColor: themeData.primaryColor,
                                bufferedColor: themeData.accentColor,
                                backgroundColor: Colors.white,
                                dragBarColor: Colors.white,
                                height: 4,
                                progressRadius: 4,
                                dragHeight: 5),
                            playIcon: Icon(Icons.play_arrow,
                                color: Colors.white, size: 16),
                            pauseIcon: Icon(
                              Icons.pause,
                              color: Colors.white,
                              size: 16,
                            ),
                            rewindIcon: Icon(
                              Icons.replay_30,
                              size: 16,
                              color: Colors.white,
                            ),
                            forwardIcon: Icon(
                              Icons.forward_30,
                              size: 16,
                              color: Colors.white,
                            ),
                            fullscreenIcon: Icon(
                              Icons.fullscreen,
                              size: 16,
                              color: Colors.white,
                            ),
                            fullscreenExitIcon: Icon(
                              Icons.fullscreen_exit,
                              size: 16,
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
                          _controller = val;
                          
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
                    (MediaQuery.of(context).orientation ==
                            Orientation.landscape)
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
                                    model.selectedSfv.title,
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
                    Expanded(child: _buildSfvsList(model))
                  ],
                ),
    );
  }

  Widget _buildSfvsList(SfvViewModel model) {
    return ListView.builder(
      itemCount: model.sfvList.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Offstage();
        }
        return ListTile(
          title: Text(model.sfvList[index].title),
          onTap: () {
           // _controller.pause();
           // _controller.initialize();
            model.selectSfv(model.sfvList[index]);
          },
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:myvoicecounts/core/core.dart';
// import 'package:myvoicecounts/features/sfv/presentation/view_models/sfv_view_model.dart';

// import 'package:responsive_builder/responsive_builder.dart';
// import 'package:video_player/video_player.dart';
// import '../widgets/video_player.dart';

// class SfvViewMobile extends StatefulWidget {
//   final SfvViewModel model;

//   const SfvViewMobile({Key key, this.model}) : super(key: key);
//   @override
//   _SfvViewMobileState createState() => _SfvViewMobileState();
// }

// class _SfvViewMobileState extends State<SfvViewMobile> {
//   VideoPlayerController _controller;
//   String _url;

//   @override
//   void initState() {
//     super.initState();
//     print("setstate called");
//     if (_url != null) {
//       _controller = VideoPlayerController.network(_url)
//         ..initialize().then((_) {
//           setState(() {});
//         });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveBuilder(
//       builder: (context, sizingInfo) => ScaffoldMobile(
//         title: Text("SFV", style: themeData.textTheme.body1,),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 "Video Title",
//                 style: themeData.textTheme.body1.copyWith(
//                     color: Colors.black54,
//                     fontSize: sizingInfo.screenSize.width * 0.08),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               Divider(
//                 height: 0,
//               ),
//               (_url != null)
//                   ? _controller.value.initialized
//                       ? Column(
//                           children: <Widget>[
//                             Container(
//                               height: sizingInfo.screenSize.height * 0.3,
//                               width: sizingInfo.screenSize.width,
//                               child: VideoPlayer(
//                                 _controller,
//                               ),
//                             ),
//                             SizedBox(
//                                 height: sizingInfo.screenSize.height * 0.02),
//                             FloatingActionButton(
//                               backgroundColor: themeData.primaryColor,
//                               foregroundColor: Colors.white,
//                               elevation: 0,
//                               onPressed: () {
//                                 setState(() {
//                                   _controller.value.isPlaying
//                                       ? _controller.pause()
//                                       : _controller.play();
//                                 });
//                               },
//                               child: Icon(
//                                 _controller.value.isPlaying
//                                     ? Icons.pause
//                                     : Icons.play_arrow,
//                               ),
//                             ),

//                              SizedBox(
//                 height: sizingInfo.screenSize.height * 0.02,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   InkWell(
//                       onTap: () {},
//                       child: Icon(
//                         FontAwesomeIcons.thumbsUp,
//                         color: Colors.green,
//                         size: (sizingInfo.screenSize.width < 400) ? 24 : 32,
//                       )),
//                   SizedBox(width: 8),
//                   InkWell(
//                       onTap: () {},
//                       child: Icon(
//                         FontAwesomeIcons.thumbsDown,
//                         color: Colors.red,
//                         size: (sizingInfo.screenSize.width < 400) ? 24 : 32,
//                       )),
//                   SizedBox(width: 8),
//                   InkWell(
//                       onTap: () {},
//                       child: Icon(
//                         FontAwesomeIcons.timesCircle,
//                         color: Colors.grey,
//                         size: (sizingInfo.screenSize.width < 400) ? 24 : 32,
//                       )),
//                 ],
//               ),

//                           ],
//                         )
//                       : Container(
//                           width: sizingInfo.screenSize.width,
//                           child: Image.asset('images/thumbnail.png'))
//                   : Container(
//                       width: sizingInfo.screenSize.width,
//                       height: sizingInfo.screenSize.height * 0.3,
//                       color: Colors.black,
//                     ),

//               SizedBox(
//                 height: sizingInfo.screenSize.height * 0.02,
//               ),
//               Expanded(child: _sfvList(context, sizingInfo)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _sfvList(BuildContext context, SizingInformation sizingInfo) {
//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: 10,
//       itemBuilder: (BuildContext context, int index) {
//         return Padding(
//           padding: const EdgeInsets.only(right: 16.0),
//           child: InkWell(
//             onTap: () {
//               print("tapped");
//               if(_controller != null)
//                 _controller.pause();
//               _controller = VideoPlayerController.network(
//                 'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
//                 ..initialize().then((_) {
//                   setState(() {
//                     _url = 'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4';
//                   });
//                 });
//             },
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   width: sizingInfo.screenSize.width * 0.4,
//                   child: Image.asset('images/thumbnail.png'),
//                 ),
//                 SizedBox(
//                   width: sizingInfo.screenSize.height * 0.02,
//                 ),
//                 Text(
//                   "Video Title",
//                   style: themeData.textTheme.body1.copyWith(
//                       color: Colors.black54,
//                       fontSize: sizingInfo.screenSize.width * 0.04),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
