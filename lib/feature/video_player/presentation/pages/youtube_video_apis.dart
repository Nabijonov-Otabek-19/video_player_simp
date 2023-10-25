import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoApis {
  static Future<List<VideoQualityUrls>?> getYoutubeVideoQualityUrls(
    String youtubeIdOrUrl,
    bool live,
  ) async {
    try {
      final yt = YoutubeExplode();
      final urls = <VideoQualityUrls>[];
      if (live) {
        final url = await yt.videos.streamsClient.getHttpLiveStreamUrl(
          VideoId(youtubeIdOrUrl),
        );
        urls.add(
          VideoQualityUrls(
            quality: 360,
            url: url,
          ),
        );
      } else {
        final manifest =
            await yt.videos.streamsClient.getManifest(youtubeIdOrUrl);
        urls.addAll(
          manifest.muxed.map(
            (element) => VideoQualityUrls(
              quality: int.parse(element.qualityLabel.split('p')[0]),
              url: element.url.toString(),
            ),
          ),
        );
      }
      // Close the YoutubeExplode's http client.
      yt.close();
      return urls;
    } catch (error) {
      if (error.toString().contains('XMLHttpRequest')) {}
      debugPrint('===== YOUTUBE API ERROR: $error ==========');
      rethrow;
    }
  }
}

class VideoQualityUrls {
  int quality;
  String url;

  VideoQualityUrls({
    required this.quality,
    required this.url,
  });

  @override
  String toString() => 'VideoQualityUrls(quality: $quality, urls: $url)';
}
