import '../../domain/entity/video_item.dart';

class VideoItemModel {
  const VideoItemModel({
    required this.id,
    required this.path,
    required this.username,
    required this.description,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.isLiked,
  });

  final String id;
  final String path;
  final String username;
  final String description;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final bool isLiked;

  factory VideoItemModel.fromJson(Map<String, dynamic> json) {
    return VideoItemModel(
      id: json['id'] as String,
      path: json['path'] as String,
      username: json['username'] as String,
      description: json['description'] as String,
      likeCount: (json['likeCount'] as num).toInt(),
      commentCount: (json['commentCount'] as num).toInt(),
      shareCount: (json['shareCount'] as num).toInt(),
      isLiked: json['isLiked'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'path': path,
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
    path: path,
    username: username,
    description: description,
    likeCount: likeCount,
    commentCount: commentCount,
    shareCount: shareCount,
    isLiked: isLiked,
  );
}