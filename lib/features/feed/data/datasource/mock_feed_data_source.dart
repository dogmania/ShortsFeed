import '../model/video_item_model.dart';
import 'feed_data_source.dart';

class MockFeedDataSource implements FeedDataSource  {
  @override
  Future<List<VideoItemModel>> fetchVideos() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    const asset1 = 'assets/videos/feed_1.mp4';
    const asset2 = 'assets/videos/feed_2.mp4';
    const asset3 = 'assets/videos/feed_3.mp4';

    return const [
      VideoItemModel(
        id: 'video_1',
        path: asset1,
        username: 'travel.daily',
        description: '도심 야경 한 바퀴',
        likeCount: 1203,
        commentCount: 84,
        shareCount: 21,
        isLiked: false,
      ),
      VideoItemModel(
        id: 'video_2',
        path: asset2,
        username: 'food.snap',
        description: '오늘 점심은 파스타',
        likeCount: 842,
        commentCount: 31,
        shareCount: 8,
        isLiked: true,
      ),
      VideoItemModel(
        id: 'video_3',
        path: asset3,
        username: 'cat.minute',
        description: '고양이 낮잠 타임',
        likeCount: 9832,
        commentCount: 411,
        shareCount: 109,
        isLiked: false,
      ),
      VideoItemModel(
        id: 'video_4',
        path: asset1,
        username: 'fit.clip',
        description: '하체 루틴 20초 요약',
        likeCount: 4211,
        commentCount: 123,
        shareCount: 55,
        isLiked: false,
      ),
      VideoItemModel(
        id: 'video_5',
        path: asset2,
        username: 'dog.walk',
        description: '산책 브이로그',
        likeCount: 650,
        commentCount: 17,
        shareCount: 4,
        isLiked: false,
      ),
      VideoItemModel(
        id: 'video_6',
        path: asset3,
        username: 'ocean.loop',
        description: '파도 소리 멍때리기',
        likeCount: 20444,
        commentCount: 901,
        shareCount: 302,
        isLiked: true,
      ),
      VideoItemModel(
        id: 'video_7',
        path: asset1,
        username: 'night.city',
        description: '심야 드라이브 기록',
        likeCount: 1502,
        commentCount: 63,
        shareCount: 17,
        isLiked: false,
      ),
      VideoItemModel(
        id: 'video_8',
        path: asset2,
        username: 'home.cafe',
        description: '집에서 만드는 아이스라떼',
        likeCount: 3291,
        commentCount: 142,
        shareCount: 35,
        isLiked: false,
      ),
      VideoItemModel(
        id: 'video_9',
        path: asset3,
        username: 'weekend.run',
        description: '주말 러닝 5km',
        likeCount: 2780,
        commentCount: 88,
        shareCount: 24,
        isLiked: true,
      ),
      VideoItemModel(
        id: 'video_10',
        path: asset1,
        username: 'desk.setup',
        description: '오늘의 작업 환경',
        likeCount: 413,
        commentCount: 12,
        shareCount: 3,
        isLiked: false,
      ),
    ];
  }
}