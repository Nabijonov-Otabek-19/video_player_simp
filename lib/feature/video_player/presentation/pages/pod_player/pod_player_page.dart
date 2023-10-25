import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class PodPlayerPage extends StatefulWidget {
  final String url;

  const PodPlayerPage({super.key, required this.url});

  @override
  State<PodPlayerPage> createState() => _PodPlayerPageState();
}

class _PodPlayerPageState extends State<PodPlayerPage> {
  late final PodPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(widget.url),
    )..initialise();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pod Player"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PodVideoPlayer(controller: _controller),
        ],
      ),
    );
  }
}
