import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelsScreen extends StatefulWidget {
  @override
  _ReelsScreenState createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final List<String> videoUrls = [
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return ReelVideoItem(videoUrl: videoUrls[index]);
        },
      ),
    );
  }
}

class ReelVideoItem extends StatefulWidget {
  final String videoUrl;
  const ReelVideoItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _ReelVideoItemState createState() => _ReelVideoItemState();
}

class _ReelVideoItemState extends State<ReelVideoItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        GestureDetector(
          onTap: () {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
            setState(() {});
          },
          child: SizedBox.expand(
            child: _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : const Center(child: CircularProgressIndicator()),
          ),
        ),

        // Overlay UI
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "@flutterdev204",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              const SizedBox(height: 5),
              const Text(
                "This is a sample reel caption with #Flutter #Dev",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 10),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: const [
                      Icon(Icons.favorite, color: Colors.white, size: 30),
                      SizedBox(height: 5),
                      Text("12K", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: const [
                      Icon(Icons.comment, color: Colors.white, size: 30),
                      SizedBox(height: 5),
                      Text("2.1K", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: const [
                      Icon(Icons.share, color: Colors.white, size: 30),
                      SizedBox(height: 5),
                      Text("1.5K", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
