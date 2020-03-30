import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myvoicecounts/core/core.dart';
import 'package:myvoicecounts/features/sfv/data/sfv_model.dart';
import 'package:myvoicecounts/features/sfv/presentation/view_models/sfv_view_model.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlaySfvWidget extends StatefulWidget {
  final SfvViewModel model;
  final Sfv sfv;

  const PlaySfvWidget({Key key, this.model, this.sfv}) : super(key: key);

  @override
  _PlaySfvWidgetState createState() => _PlaySfvWidgetState();
}

class _PlaySfvWidgetState extends State<PlaySfvWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  final List<String> _ids = [
    'lgkZC_Ss6YE',
    'gQDByCdjUXw',
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ',
    'p2lYr3vM_1w',
    '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.sfv.link),
      flags: YoutubePlayerFlags(
        controlsVisibleAtStart: true,
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHideAnnotation: true,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInfo) => Column(
          children: <Widget>[
            Padding(
              padding:
                  (MediaQuery.of(context).orientation == Orientation.landscape)
                      ? EdgeInsetsDirectional.only(top: 0)
                      : EdgeInsetsDirectional.only(top: 24),
              child: YoutubePlayer(

                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: themeData.primaryColor,
                progressColors: ProgressBarColors(
                        handleColor: themeData.primaryColor,
                        bufferedColor: themeData.accentColor,
                        playedColor: themeData.primaryColor,
                        backgroundColor: Colors.white
                      ),
                bottomActions: [
                  CurrentPosition(),
                  SizedBox(width: 8,),
                  ProgressBar(
                      isExpanded: true,
                      colors: ProgressBarColors(
                        handleColor: themeData.primaryColor,
                        bufferedColor: themeData.accentColor,
                        playedColor: themeData.primaryColor,
                        backgroundColor: Colors.white
                      )),
                  RemainingDuration(),
                  FullScreenButton()
                    
                  // TotalDuration(),
                ],
                topActions: <Widget>[
                  
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: (){
                      Modular.to.pop();
                    },
                  ),
                  Expanded(
                    child: Text(
                      _controller.metadata.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: (sizingInfo.screenSize.width < 600) ? 14 : 18.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
                onReady: () {
                  _isPlayerReady = true;
                },
                onEnded: (data) {
                  _controller.load(
                      _ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
                  //_showSnackBar('Next Video Started!');
                },
              ),
            ),
            (MediaQuery.of(context).orientation == Orientation.landscape)
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
                            widget.sfv.title,
                          // _controller.metadata.title,
                            style: themeData.textTheme.body1.copyWith(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
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
