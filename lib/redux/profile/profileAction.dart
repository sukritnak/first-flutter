import 'package:firstFlutter/redux/profile/profileReducer.dart';
import 'package:meta/meta.dart';

@immutable
class GetProfileAction {
  final ProfileState profileState;

  GetProfileAction(this.profileState);
}

//action

getProfileAction(Map profile) {
  // ถ้าจะใช้ async await ที่ action ต้องลง redux thunk
  //logic => insert update delete

  return GetProfileAction(ProfileState(profile: profile));
}
