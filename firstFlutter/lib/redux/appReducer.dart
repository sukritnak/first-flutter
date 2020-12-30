import 'package:firstFlutter/redux/profile/profileReducer.dart';
import 'package:meta/meta.dart';

// สร้างตัวนี้เป็น root reducer
// รวม reducer ทั้งหลาย ย่อย ๆ

@immutable
class AppState {
  final ProfileState profileState;

  AppState({this.profileState});

  // สร้างอีก constructor ในการ return appState ตัวมันเองออกไป
  factory AppState.initial() {
    return AppState(profileState: ProfileState());
  }
}

AppState appReducer(AppState state, dynamic action) {
  return AppState(profileState: profileReducer(state.profileState, action));
}
