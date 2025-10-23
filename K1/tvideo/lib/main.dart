import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

const String _networkImageUrl = 'https://picsum.photos/400/200';
const String _networkVideoUrl =
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

const String _assetImagePath = 'assets/images/Pemandangan.jpg';
const String _assetVideoPath = 'assets/videos/roblox.mp4';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Multimedia Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MediaDisplayScreen(),
    );
  }
}

class MediaDisplayScreen extends StatelessWidget {
  const MediaDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tampilan Gambar & Video'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- BAGIAN GAMBAR ---
            const Text(
              '1. Gambar dari Aset Lokal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Center(
              child: Image.asset(
                _assetImagePath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Text(
                    '❌ ASET LOKAL GAGAL DIMUAT.\nCek file pubspec.yaml & path: assets/images/sample_local.jpg',
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            const Divider(height: 32, thickness: 2),

            const Text(
              '2. Gambar dari Jaringan (Network)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Center(
              child: Image.network(
                _networkImageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Text(
                    '❌ GAMBAR JARINGAN GAGAL DIMUAT.\nCek URL: https://picsum.photos/400/200',
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            const Divider(height: 32, thickness: 2),

            const Text(
              '3. Video dari Jaringan (Network) dengan Kontrol',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            VideoPlayerWidget(videoUrl: _networkVideoUrl, isAsset: false),
            const Divider(height: 32, thickness: 2),

            const Text(
              '4. Video dari Aset Lokal (Assets) dengan Kontrol',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            VideoPlayerWidget(videoUrl: _assetVideoPath, isAsset: true),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final bool isAsset;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    required this.isAsset,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    if (widget.isAsset) {
      _controller = VideoPlayerController.asset(widget.videoUrl);
    } else {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );
    }

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  '❌ GAGAL MEMUAT VIDEO: ${snapshot.error.toString()}',
                ),
              );
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),

        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: () {
            setState(() {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ],
    );
  }
}
