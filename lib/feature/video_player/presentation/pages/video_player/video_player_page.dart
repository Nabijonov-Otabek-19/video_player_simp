import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:tdd_test/feature/video_player/presentation/pages/youtube_video_apis.dart';

import '../video_player_config.dart';

class VideoPlayerPage extends StatefulWidget {
  final String url;

  const VideoPlayerPage({super.key, required this.url});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController? _controller;
  late final ChewieController _chewieController;

  List<VideoQualityUrls> vimeoOrVideoUrls = [];
  late String _videoQualityUrl;
  int? vimeoPlayingVideoQuality;

  @override
  void initState() {
    super.initState();

    getVideoQualityUrlsFromYoutube(widget.url, false).then((urls) {
      getUrlFromVideoQualityUrls(
        qualityList: const MyPlayerConfig().videoQualityPriority,
        videoUrls: urls,
      ).then((url) {
        _controller = VideoPlayerController.networkUrl(Uri.parse(url))
          ..addListener(() => setState(() {}))
          ..initialize().then((value) => setState(() {}))
          ..setLooping(true)
          ..play();
      });
    });

    /*_chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: true,
    );*/

    /*_controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..setLooping(true)
      ..setVolume(1.0)
      ..addListener(() => setState(() {}))
      ..initialize().then((_) => setState(() {}))
      ..play();*/
  }

  @override
  void dispose() {
    _controller?.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Player"),
      ),
      body: Center(
        child: _controller != null
            ? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  Future<List<VideoQualityUrls>> getVideoQualityUrlsFromYoutube(
    String youtubeIdOrUrl,
    bool live,
  ) async {
    return await VideoApis.getYoutubeVideoQualityUrls(youtubeIdOrUrl, live) ??
        [];
  }

  Future<String> getUrlFromVideoQualityUrls({
    required List<int> qualityList,
    required List<VideoQualityUrls> videoUrls,
  }) async {
    sortQualityVideoUrls(videoUrls);
    if (vimeoOrVideoUrls.isEmpty) {
      throw Exception('videoQuality cannot be empty');
    }

    final fallback = vimeoOrVideoUrls[0];
    VideoQualityUrls? urlWithQuality;
    for (final quality in qualityList) {
      urlWithQuality = vimeoOrVideoUrls.firstWhere(
        (url) => url.quality == quality,
        orElse: () => fallback,
      );
      if (urlWithQuality != fallback) {
        break;
      }
    }

    urlWithQuality ??= fallback;
    _videoQualityUrl = urlWithQuality.url;
    vimeoPlayingVideoQuality = urlWithQuality.quality;
    return _videoQualityUrl;
  }

  void sortQualityVideoUrls(
    List<VideoQualityUrls>? urls,
  ) {
    final urls0 = urls;

    urls0?.removeWhere((element) => element.quality == 240);

    if (kIsWeb) {
      urls0?.removeWhere((element) => element.quality == 144);
    }

    urls0?.sort((a, b) => a.quality.compareTo(b.quality));

    vimeoOrVideoUrls = urls0 ?? [];
  }
}
