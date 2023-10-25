class MyPlayerConfig {
  final bool autoPlay;
  final bool isLooping;
  final bool forcedVideoFocus;
  final bool wakelockEnabled;
  final List<int> videoQualityPriority;

  const MyPlayerConfig({
    this.autoPlay = true,
    this.isLooping = false,
    this.forcedVideoFocus = false,
    this.wakelockEnabled = true,
    this.videoQualityPriority = const [1080, 720, 360],
  });

  MyPlayerConfig copyWith({
    bool? autoPlay,
    bool? isLooping,
    bool? forcedVideoFocus,
    bool? wakelockEnabled,
    List<int>? videoQualityPriority,
  }) {
    return MyPlayerConfig(
      autoPlay: autoPlay ?? this.autoPlay,
      isLooping: isLooping ?? this.isLooping,
      forcedVideoFocus: forcedVideoFocus ?? this.forcedVideoFocus,
      wakelockEnabled: wakelockEnabled ?? this.wakelockEnabled,
      videoQualityPriority: videoQualityPriority ?? this.videoQualityPriority,
    );
  }
}
