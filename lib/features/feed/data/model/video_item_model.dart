import '../../domain/entity/video_item.dart';

class VideoItemModel {
  const VideoItemModel({
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

  factory VideoItemModel.fromJson(Map<String, dynamic> json) {
    return VideoItemModel(
      id: json['id'] as String,
      videoUrl: json['videoUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      username: json['username'] as String,
      description: json['description'] as String,
      likeCount: json['likeCount'] as int,
      commentCount: json['commentCount'] as int,
      shareCount: json['shareCount'] as int,
      isLiked: json['isLiked'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'username': username,
      'description': description,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'shareCount': shareCount,
      'isLiked': isLiked,
    };
  }

  VideoItem toEntity() => VideoItem(
    id: id,
    videoUrl: videoUrl,
    thumbnailUrl: thumbnailUrl,
    username: username,
    description: description,
    likeCount: likeCount,
    commentCount: commentCount,
    shareCount: shareCount,
    isLiked: isLiked,
  );
}