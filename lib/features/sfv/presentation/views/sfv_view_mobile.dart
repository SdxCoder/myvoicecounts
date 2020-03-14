import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:video_player/video_player.dart';
import '../widgets/video_player.dart';

class SfvViewMobile extends StatefulWidget {
  @override
  _SfvViewMobileState createState() => _SfvViewMobileState();
}

class _SfvViewMobileState extends State<SfvViewMobile> {
  VideoPlayerController _controller;
  String _url;

  @override
  void initState() {
    super.initState();
    print("setstate called");
    if (_url != null) {
      _controller = VideoPlayerController.network(_url)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => ScaffoldMobile(
        title: Text("SFV", style: themeData.textTheme.body1,),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              (_url != null)
                  ? _controller.value.initialized
                      ? Column(
                          children: <Widget>[
                            Container(
                              height: sizingInfo.screenSize.height * 0.3,
                              width: sizingInfo.screenSize.width,
                              child: VideoPlayer(
                                _controller,
                              ),
                            ),
                            SizedBox(
                                height: sizingInfo.screenSize.height * 0.02),
                            FloatingActionButton(
                              backgroundColor: themeData.primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              onPressed: () {
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                              child: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                            ),

                             SizedBox(
                height: sizingInfo.screenSize.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        FontAwesomeIcons.thumbsUp,
                        color: Colors.green,
                        size: (sizingInfo.screenSize.width < 400) ? 24 : 32,
                      )),
                  SizedBox(width: 8),
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        FontAwesomeIcons.thumbsDown,
                        color: Colors.red,
                        size: (sizingInfo.screenSize.width < 400) ? 24 : 32,
                      )),
                  SizedBox(width: 8),
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        FontAwesomeIcons.timesCircle,
                        color: Colors.grey,
                        size: (sizingInfo.screenSize.width < 400) ? 24 : 32,
                      )),
                ],
              ),


                          ],
                        )
                      : Container(
                          width: sizingInfo.screenSize.width,
                          child: Image.asset('images/thumbnail.png'))
                  : Container(
                      width: sizingInfo.screenSize.width,
                      height: sizingInfo.screenSize.height * 0.3,
                      color: Colors.black,
                    ),
             
              SizedBox(
                height: sizingInfo.screenSize.height * 0.02,
              ),
              Expanded(child: _sfvList(context, sizingInfo)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sfvList(BuildContext context, SizingInformation sizingInfo) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: InkWell(
            onTap: () {
              print("tapped");
              if(_controller != null)
                _controller.pause();
              _controller = VideoPlayerController.network(
                'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
                ..initialize().then((_) {
                  setState(() {
                    _url = 'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4';
                  });
                });
            },
            child: Column(
              children: <Widget>[
                Container(
                  width: sizingInfo.screenSize.width * 0.4,
                  child: Image.asset('images/thumbnail.png'),
                ),
                SizedBox(
                  width: sizingInfo.screenSize.height * 0.02,
                ),
                Text(
                  "Video Title",
                  style: themeData.textTheme.body1.copyWith(
                      color: Colors.black54,
                      fontSize: sizingInfo.screenSize.width * 0.04),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
