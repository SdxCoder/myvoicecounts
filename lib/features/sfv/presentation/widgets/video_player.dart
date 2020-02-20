import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  final SizingInformation sizingInfo;
  final String url;

  VideoApp({Key key, this.sizingInfo, this.url}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldTablet(
        body: (widget.url != null)
            ? _controller.value.initialized
                ? Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Video Title",
                          style: themeData.textTheme.body1.copyWith(
                              color: Colors.black54,
                              fontSize:
                                  widget.sizingInfo.screenSize.height * 0.04),
                        ),
                        SizedBox(
                          height: widget.sizingInfo.screenSize.height * 0.01,
                        ),
                        Container(
                          height: widget.sizingInfo.screenSize.height * 0.55,
                          width: widget.sizingInfo.screenSize.width,
                          child: VideoPlayer(
                            _controller,
                          ),
                        ),
                        SizedBox(
                          height: widget.sizingInfo.screenSize.height * 0.02,
                        ),
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
                          height: widget.sizingInfo.screenSize.height * 0.02,
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
                                  size:
                                      (widget.sizingInfo.screenSize.width < 400)
                                          ? 24
                                          : 32,
                                )),
                            SizedBox(width: 8),
                            InkWell(
                                onTap: () {},
                                child: Icon(
                                  FontAwesomeIcons.thumbsDown,
                                  color: Colors.red,
                                  size:
                                      (widget.sizingInfo.screenSize.width < 400)
                                          ? 24
                                          : 32,
                                )),
                            SizedBox(width: 8),
                            InkWell(
                                onTap: () {},
                                child: Icon(
                                  FontAwesomeIcons.timesCircle,
                                  color: Colors.grey,
                                  size:
                                      (widget.sizingInfo.screenSize.width < 400)
                                          ? 24
                                          : 32,
                                )),
                          ],
                        ),
                        SizedBox(
                            height: widget.sizingInfo.screenSize.height * 0.03),
                        SizedBox(
                          width: widget.sizingInfo.screenSize.width * 0.2,
                          height: (widget.sizingInfo.screenSize.height < 600)
                              ? 40
                              : 60,
                          child: RaisedButton(
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              "GO Back",
                              style: themeData.textTheme.body1,
                            ),
                            onPressed: () {
                              // if(_controller != null){
                              //   _controller.pause();
                              // }
                              
                              Navigator.of(context).pop();

                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            themeData.primaryColorDark),
                      ),
                    ),
                  )
            : Container(
                height: widget.sizingInfo.screenSize.height,
                color: Colors.black,
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class VideoAppMini extends StatefulWidget {
  @override
  _VideoAppMiniState createState() => _VideoAppMiniState();
}

class _VideoAppMiniState extends State<VideoAppMini> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            _controller.value.initialized
                ? SizedBox(
                    height: 80,
                    width: 130,
                    child: VideoPlayer(
                      _controller,
                    ),
                  )
                : Container(
                    height: 80,
                    width: 130,
                    child: Image.asset('images/thumbnail.png')),
            SizedBox(height: 16),
            Text("Video Title", style: TextStyle(color: Colors.black54)),
          ],
        )
        // Positioned(
        //   bottom: 0,
        //   right: 15,
        //   child: FloatingActionButton(
        //     onPressed: () {
        //       setState(() {
        //         _controller.value.isPlaying
        //             ? _controller.pause()
        //             : _controller.play();
        //       });
        //     },
        //     child: Icon(
        //       _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
