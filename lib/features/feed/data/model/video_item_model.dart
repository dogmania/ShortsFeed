import '../../domain/entity/video_item.dart';

class VideoItemModel extends VideoItem {
  const VideoItemModel({
    required super.id,
    required super.videoUrl,
    required super.thumbnailUrl,
    required super.username,
    required super.description,
    required super.likeCount,
    required super.commentCount,
    required super.shareCount,
    required super.isLiked,
  });

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

  factory VideoItemModel.fromEntity(VideoItem entity) {
    return VideoItemModel(
      id: entity.id,
      videoUrl: entity.videoUrl,
      thumbnailUrl: entity.thumbnailUrl,
      username: entity.username,
      description: entity.description,
      likeCount: entity.likeCount,
      commentCount: entity.commentCount,
      shareCount: entity.shareCount,
      isLiked: entity.isLiked,
    );
  }
}