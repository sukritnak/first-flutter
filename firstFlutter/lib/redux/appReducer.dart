import 'package:firstFlutter/redux/product/productReducer.dart';
import 'package:firstFlutter/redux/profile/profileReducer.dart';
import 'package:meta/meta.dart';

// สร้างตัวนี้เป็น root reducer
// รวม reducer ทั้งหลาย ย่อย ๆ

@immutable
class AppState {
  final ProfileState profileState;
  final ProductState productState;

  AppState({this.profileState, this.productState});

  // สร้างอีก constructor ในการ return appState ตัวมันเองออกไป
  factory AppState.initial() {
    return AppState(profileState: ProfileState(), productState: ProductState());
  }
}

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      profileState: profileReducer(state.profileState, action),
      productState: productReducer(state.productState, action));
}
