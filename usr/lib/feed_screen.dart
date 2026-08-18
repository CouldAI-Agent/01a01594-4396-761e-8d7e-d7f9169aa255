import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final PageController _pageController = PageController();

  final List<String> _dummyVideos = [
    'Video 1',
    'Video 2',
    'Video 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _dummyVideos.length,
        itemBuilder: (context, index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: index % 2 == 0 ? Colors.blueGrey : Colors.teal,
                child: Center(
                  child: Text(
                    _dummyVideos[index],
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildActionButton(Icons.favorite, '12K'),
                    const SizedBox(height: 20),
                    _buildActionButton(Icons.comment, '145'),
                    const SizedBox(height: 20),
                    _buildDownloadButton(),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '@user$index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Awesome video! #trending',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 35),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildDownloadButton() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video downloading...')),
        );
      },
      child: Column(
        children: const [
          Icon(Icons.download, color: Colors.white, size: 35),
          SizedBox(height: 5),
          Text('Download', style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
