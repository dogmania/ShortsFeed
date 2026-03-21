# 1. 프로젝트 소개

이 프로젝트는 Flutter 기반의 TikTok 스타일 숏폼 비디오 피드 프로젝트입니다.
외부 서버 대신 mock 데이터와 로컬 asset 영상을 사용해 핵심 UX 구현에 집중했습니다. 특히 현재 페이지의 영상만 재생되고, 화면을 벗어난 영상은 즉시 pause 되도록 하는 피드 경험 구현을 핵심 목표로 두었습니다.

주요 목표는 3가지입니다.
- vertical swipe 기반 피드 경험
- 현재 화면의 영상만 안정적으로 재생
- 좋아요, 탭/더블탭 등 기본 상호작용 구현

# 2. 실행 방법
실행 환경은 Flutter 3.41.4 / Dart 3.11.1 기준으로 구성했으며, iOS Simulator와 Android Emulator에서 동작을 확인했습니다.

## 2-1. 프로젝트 클론
```
git clone https://github.com/dogmania/ShortsFeed.git
cd ShortsFeed
```

## 2-2. 패키지 설치
```
flutter pub get
```

## 2-3. 앱 실행
iOS Simulator 또는 Android Emulator를 준비한 뒤 아래 명령어를 터미널에서 실행
```
flutter run
```

# 3. 사용한 패키지
### flutter_riverpod
앱 상태 관리를 위해 사용했습니다.

사용 이유:
- 비동기 상태를 AsyncValue로 다루기 용이함
- UI에서 로딩/성공/실패 분기 처리가 편리함
- UI와 상태 변경 로직을 분리해 화면에서는 렌더링에 집중할 수 있도록 하기 위함

적용 범위:
- feed 상태
- current page 상태
- like 상태

### video_player
숏폼 피드의 영상 재생 기능을 위해 사용했습니다.

사용 이유:
- autoplay / pause / resume / looping / buffering 처리를 안정적으로 구현하기 위함
- 현재 페이지 기준 재생 제어 로직을 구현하기 적합한 표준 패키지이기 때문

적용 범위:
- 현재 페이지 영상 자동 재생
- 비활성 페이지 pause
- 탭 시 pause / resume
- 버퍼링 UI 처리

### flutter_svg
overlay 액션 버튼 아이콘을 렌더링하기 위해 사용했습니다.

사용 이유:
- SVG asset 기반 아이콘을 선명하게 표현하기 위함
- 좋아요/댓글 등 액션 UI를 일관성 있게 구성하기 위함

# 4. 프로젝트 구조
이 프로젝트는 feature 중심 구조를 기반으로, 과도한 추상화를 피하면서 계층 분리가 명확하도록 구성했습니다.

```
lib/
  app/

  core/
    constants/
    theme/

  features/
    feed/
      data/
        datasource/
        model/
        repository/
          
      di/

      domain/
        entity/
        repository/
        usecase/

      presentation/
        provider/
        screen/
        widget/

  main.dart
```

# 5. 구현 기능 목록

### 필수 기능

- Vertical Video Feed
- PageView 기반 vertical swipe 
- 현재 화면 video autoplay 
- 화면을 벗어난 video pause 
- video_player 기반 영상 재생 
- buffering 상태 표시 
- overlay UI 표시

### 추가 구현 기능

- 좋아요 토글
- 현재 페이지 영상 single tap 시 pause / resume
- 현재 페이지 영상 double tap 시 좋아요 토글
- tap/double tap 시 시각적 피드백 표시
- 좋아요 수 UI 반영

### 확장 가능 기능

- preload
- 네트워크 API 연동
- 댓글 바텀시트/상세 인터랙션
- 썸네일 및 캐싱 전략

# 6. AI 사용 내역 및 대화 기록

## 6-1. AI 사용 여부
사용했습니다.

## 6-2. 사용한 AI 도구

- ChatGPT
- Gemini: AI Agent 문서 효용성 검증
- CodeRabbit: PR 단위 코드 리뷰 및 리팩터링 포인트 확인
- Figma Make: 화면 디자인 및 디자인 시스템 초안 탐색

## 6.3. AI를 사용한 작업 범위

AI는 아래 범위에서 활용했습니다.
- 아키텍처 리뷰 
- CodeRabbit 리뷰 정책 문서 초안 작성
- 좋아요/댓글 Overlay UI 초안 검토 및 구조 대안 비교
- 탭/더블탭 gesture 처리 방식 비교 및 구현 방향 검토
- 기능 초안 구현 이후, 위젯 책임 분리와 리팩터링 포인트 검토
- PR 단위 코드 리뷰(StateProvider → NotifierProvider 전환 계기)
- 화면 디자인 방향 탐색 및 디자인 시스템 초안 정리

## 6-4. 직접 구현한 작업 범위

아래 항목은 직접 설계하거나 수정/통합한 부분입니다.
- 기술 스택 선정
- 전체 프로젝트 초기 세팅
- 폴더 구조 구성
- Riverpod Provider 연결 및 ProviderScope 정의
- PageView 기반 vertical feed 구현
- video_player 기반 영상 재생 및 lifecycle 처리
- 현재 페이지 기준 autoplay / pause 제어
- mock datasource 구성
- AI 결과물 검토 및 프로젝트 코드에 맞춘 수정/통합
- 메모리 관리 개선을 위한 provider 구조 수정 및 autoDispose 적용
- AI Agent 문서 작성(아키텍처 문서, Codebase Map)

## 6-5. AI 사용 방식에 대한 설명
AI는 초기 구조 탐색, UI 아이디어 정리, 코드 리뷰 보조, 개선 포인트 점검 용도로 활용했습니다.
AI가 제안한 코드나 구조를 그대로 반영하지 않고, 실제 요구사항과 현재 코드베이스에 맞는지 직접 검토한 뒤 필요한 부분만 수정하여 적용했습니다.

특히 프로젝트 구조와 Agent 문서를 정리한 이후에는 일부 기능에서 AI 초안을 빠르게 활용할 수 있었고, 이를 바탕으로 구현 속도를 높이되 최종 설계 판단과 통합, 검증은 직접 수행했습니다.

## 6-6. AI 코드 에이전트와의 대화 기록
대화 기록은 기능 구현 요청, 수정 요청, 코드 리뷰, 반영 결과 순서로 정리했습니다.

https://thoracic-aphid-9a1.notion.site/AI-Agent-32999613886c80328934e3a460216868

# Q1. 현재 프로젝트의 구조를 어떻게 설계했는지 설명해 주세요.

## Q1-1. 폴더 구조 설계 이유
- `app/`
    - 앱 루트 설정, MaterialApp과 같은 앱 진입 구성을 담당합니다.
- `core/`
    - spacing, theme 등 feature에 종속되지 않는 공통 요소를 둡니다.
- `features/feed/`
    - 핵심 기능이 모두 feed에 집중되어 있으므로 feature 단위로 묶으면서 확장성을 열어두었습니다.
    - `data`
        - mock datasource, model, repository 구현을 둡니다.
        - 현재는 mock 데이터를 사용하지만 이후 실제 API로 교체하기 쉽도록 분리했습니다.
    - `domain`
        - entity, repository interface, usecase를 둡니다.
        - 프레임워크 의존성이 없는 앱 핵심 타입과 계약을 모아두었습니다.
    - `presentation`
        - provider, screen, widget을 둡니다.
        - 화면 조립, 상태 연결, player/overlay UI를 담당합니다.

기능이 적고, 프로젝트 전체에서 공유하는 리소스가 없음을 고려하여 feature 중심 구조를 유지하되,
mock 데이터에서 API 기반 구조로 전환할 때 presentation 수정 범위를 줄이기 위해 data / domain / presentation 계층을 나눴습니다.

## Q1-2. 상태 관리 방식 선택 이유

### 사용 이유:
- 비동기 상태를 AsyncValue로 다루기 용이함
- UI에서 로딩/성공/실패 분기 처리가 편리함 
- UI와 상태 변경 로직을 분리해 화면에서는 렌더링에 집중할 수 있도록 하기 위함

또한 구현 과정에서 아래와 같은 방향으로 개선했습니다.

- StateProvider → NotifierProvider
- FutureProvider → AsyncNotifierProvider

초기에는 Provider가 단순히 값을 조회하고 활용하는 용도였지만 상태 관리의 책임을 Provider 내부로 통합하기 위해 개선을 결정했습니다.

## Q1-3. Video Player lifecycle 처리 방식

현재 페이지의 영상만 안정적으로 재생하도록 다음과 같이 처리했습니다.

- PageView에서 현재 페이지 index를 추적
- 각 FeedPage에 현재 활성 페이지 여부를 전달
- VideoPlayerItem은 isActive 값에 따라 play / pause 제어
- 현재 페이지가 아니면 영상 pause
- video controller는 위젯 생명주기에 맞춰 생성/해제
- buffering 중에는 별도 UI 표시
- single tap은 pause/resume, double tap은 like toggle

핵심은 VideoPlayerController를 전역 상태로 두지 않고, 위젯 생명주기와 결합된 객체로 다루면서 현재 페이지와 동기화한 점입니다.

특히, Riverpod의 .autoDispose와 위젯의 dispose()를 결합하여, 사용자가 피드를 빠르게 스크롤하더라도 백그라운드에서 불필요한 비디오 컨트롤러가 점유되지 않도록 메모리 누수를 차단했습니다.

# Q2. 이 앱을 실제 TikTok 규모 서비스로 확장해야 한다면 어떤 부분을 변경하거나 개선해야 할까요?

## Q2-1. video preload 전략

현재는 현재 페이지 중심으로 재생 안정성을 우선했습니다.

실서비스 규모에서는 다음 페이지 또는 인접 페이지를 미리 준비하는 preload 전략이 필요합니다.
- 현재 페이지 기준 +2 범위 preload
- 썸네일 선노출 후 video attach
- 메모리 사용량과 preload 범위 균형 조절
- 스크롤 속도에 따른 preload 정책 조절
- ExoPlayer/AVPlayer의 캐시 설정을 직접 커스텀

이를 위해 LRU 기반 controller pool 관리와 미리보기 썸네일 전략을 추가할 수 있습니다.

## Q2-2. 네트워크 처리
현재는 mock datasource 기반입니다. 실서비스에서는 아래 항목을 추가하여 확장할 수 있습니다.

- REST API 연동
- 네트워크 에러 처리 및 재시도
- Pagination 기반 피드 로딩
- 좋아요 optimistic update 및 서버 동기화
- repository cache 전략

## Q2-3. 상태 관리 구조

현재는 프로젝트 범위에 맞는 비교적 단순한 Riverpod 구조입니다. 실서비스에서는 아래와 같이 확장을 고려할 수 있습니다.

- 로컬 캐시와 네트워크 상태 동기화
- optimistic update 실패 시 롤백 처리
- pagination 상태 세분화 및 에러 처리

## Q2-4. 성능 최적화

필요한 개선 방향:
- controller 생성/해제 비용 최소화
- preload 범위 최적화
- 이미지/비디오 캐싱
- rebuild 범위 최소화
- overlay UI와 player rebuild 분리
- 빠른 scroll 성능 프로파일링

실서비스라면 재생 지연 최소화와 메모리 사용량 제어 사이의 균형을 중심으로 최적화하는 것이 중요합니다.


# Q3 구현 과정에서 가장 어려웠던 문제 하나를 설명해 주세요.

## Q3-1. 문제 상황
구현 과정에서 가장 어려웠던 문제는 세로 피드에서 현재 화면의 영상만 자동 재생하고, 화면을 벗어난 영상은 자동으로 pause 되도록 안정적으로 제어하는 것이었습니다.

단순히 영상을 재생하는 것 자체는 어렵지 않았지만, 숏폼 피드에서는 사용자가 페이지를 빠르게 넘기기 때문에  
“지금 어떤 페이지가 활성 상태인지”와 “어떤 player가 실제로 재생되어야 하는지”를 명확하게 연결하는 것이 중요했습니다.

또한 각 페이지가 자체적으로 player를 가지고 있기 때문에, 현재 페이지가 아닌 영상까지 불필요하게 살아 있거나 재생 상태가 어긋나면  
UX뿐 아니라 메모리 관리 측면에서도 좋지 않다고 판단했습니다.

## Q3-2. 시도한 해결 방법
처음에는 각 피드 아이템이 자기 내부에서 재생 상태를 관리하는 방식으로 접근할 수도 있었지만,  
이 경우 페이지 전환 기준과 재생 상태 기준이 분리되어 구조가 흐려질 수 있다고 판단했습니다.

그래서 현재 어떤 페이지가 활성 상태인지 먼저 별도 상태로 관리하고,  
각 아이템은 그 상태를 전달받아 자신이 재생 대상인지 아닌지만 판단하도록 구조를 정리했습니다.

## Q3-3. 최종 해결 방법
최종적으로는 `PageView`의 현재 페이지 index를 상태로 관리하고,  
각 `FeedPage`에 자신이 현재 페이지인지 여부를 `isActive` 형태로 전달한 뒤,  
`VideoPlayerItem`이 그 값을 기준으로 play / pause를 제어하도록 구현했습니다.

정리하면 다음 흐름입니다.

1. `PageView`에서 현재 페이지 index 추적
2. 각 `FeedPage`에 현재 페이지 여부 전달
3. `VideoPlayerItem`은 `isActive == true`일 때만 재생
4. 현재 페이지가 아니면 pause
5. controller는 위젯 생명주기에 맞춰 생성/해제

이 방식으로 정리하면서
- 현재 화면 영상만 재생된다는 기준이 분명해졌고
- 페이지 전환과 재생 제어 흐름이 단순해졌으며
- controller도 필요 이상으로 오래 유지하지 않도록 관리할 수 있었습니다.








