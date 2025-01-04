import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:self_help/pages/global_providers/user_auth_provider.dart';

part 'overlay_provider.g.dart';

enum PageOverlayState { hidden, loading, offline }

@riverpod
class PageOverlay extends _$PageOverlay {
  @override
  PageOverlayState build() {
    final authState = ref.watch(userAuthProvider);

    authState.when(
      data: (state) {
        return PageOverlayState.hidden;
      },
      error: (error, stackTrace) {
        return PageOverlayState.hidden;
      },
      loading: () {
        return PageOverlayState.loading;
      },
    );
    return PageOverlayState.hidden;
  }

  void updateState(PageOverlayState value) {
    state = value;
  }
}
