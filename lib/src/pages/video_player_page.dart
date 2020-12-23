import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String url = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.black,
      body: _Body(url),
    );
  }
}

class _Body extends StatefulWidget {
  final String url;

  const _Body(this.url);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  VideoPlayerController _controller;
  Future<void> _initializedVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _initializedVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializedVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _Player(controller: _controller);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class _Player extends StatefulWidget {
  final VideoPlayerController controller;

  const _Player({this.controller});

  @override
  __PlayerState createState() => __PlayerState();
}

class __PlayerState extends State<_Player> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AspectRatio(
              aspectRatio: widget.controller.value.aspectRatio,
              child: VideoPlayer(widget.controller),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: _animationController,
                  ),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      if (widget.controller.value.isPlaying) {
                        _animationController.reverse();
                        widget.controller.pause();
                      } else {
                        _animationController.forward();
                        widget.controller.play();
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
