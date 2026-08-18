import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final List<String> videoUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return VideoPlayerItem(videoUrl: videoUrls[index]);
        },
      ),
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({super.key, required this.videoUrl});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _controller;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _downloadVideo() {
    setState(() {
      _isDownloading = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Downloading video...')),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Download complete!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_controller.value.isInitialized)
          Center(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          )
        else
          const Center(child: CircularProgressIndicator(color: Colors.white)),
        Positioned(
          right: 16,
          bottom: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.white, size: 40),
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              IconButton(
                icon: const Icon(Icons.chat_bubble, color: Colors.white, size: 40),
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              IconButton(
                icon: _isDownloading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Icon(Icons.download, color: Colors.white, size: 40),
                onPressed: _downloadVideo,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
