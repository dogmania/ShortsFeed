class VideoItem {
  const VideoItem({
    required this.id,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.username,
    required this.description,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.isLiked,
  });

  final String id;
  final String videoUrl;
  final String thumbnailUrl;
  final String username;
  final String description;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final bool isLiked;

  VideoItem copyWith({
    String? id,
    String? videoUrl,
    String? thumbnailUrl,
    String? username,
    String? description,
    int? likeCount,
    int? commentCount,
    int? shareCount,
    bool? isLiked,
  }) {
    return VideoItem(
      id: id ?? this.id,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      username: username ?? this.username,
      description: description ?? this.description,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}