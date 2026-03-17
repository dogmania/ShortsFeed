import '../model/video_item_model.dart';

class MockVideoDataSource {
  Future<List<VideoItemModel>> fetchVideos() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));

    return const [
      VideoItemModel(
        id: 'video_1',
        videoUrl: 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4',
        thumbnailUrl: 'https://picsum.photos/id/1011/400/700',
        username: 'travel.daily',
        description: '도심 야경 한 바퀴',
        likeCount: 1203,
        commentCount: 84,
        shareCount: 21,
        isLiked: false,
      ),
      VideoItemModel(
        id: 'video_2',
        videoUrl: 'https://samplelib.com/lib/preview/mp4/sample-10s.mp4',
        thumbnailUrl: 'https://picsum.photos/id/1015/400/700',
        username: 'food.snap',
        description: '오늘 점심은 파스타',
        likeCount: 842,
        commentCount: 31,
        shareCount: 8,
        isLiked: true,
      ),
      VideoItemModel(
        id: 'video_3',
        videoUrl: 'https://samplelib.com/lib/preview/mp4/sample-15s.mp4',
        thumbnailUrl: 'https://picsum.photos/id/1016/400/700',
        username: 'cat.minute',
        description: '고양이 낮잠 타임',
        likeCount: 9832,
        commentCount: 411,
        shareCount: 109,
        isLiked: false,
      ),
      VideoItemModel(
        id: 'video_4',
        videoUrl: 'https://samplelib.com/lib/preview/mp4/sample-20s.mp4',
        thumbnailUrl: 'https://picsum.photos/id/1020/400/700',
        username: 'fit.clip',
        description: '하체 루틴 20초 요약',
        likeCount: 4211,
        commentCount: 123,
        shareCount: 55,
        isLiked: false,
      ),
      VideoItemModel(
        id: 'video_5',
        videoUrl: 'https://samplelib.com/lib/preview/mp4/sample-30s.mp4',
        thumbnailUrl: 'https://picsum.photos/id/1024/400/700',
        username: 'dog.walk',
        description: '산책 브이로그',
        likeCount: 650,
        commentCount: 17,
        shareCount: 4,
        isLiked: false,
      ),
      VideoItemModel(
        id: 'video_6',
        videoUrl: 'https://samplelib.com/lib/preview/mp4/sample-5mb.mp4',
        thumbnailUrl: 'https://picsum.photos/id/1027/400/700',
        username: 'ocean.loop',
        description: '파도 소리 멍때리기',
        likeCount: 20444,
        commentCount: 901,
        shareCount: 302,
        isLiked: true,
      ),
    ];
  }
}