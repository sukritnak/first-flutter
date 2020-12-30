import 'package:firstFlutter/redux/profile/profileAction.dart';
import 'package:meta/meta.dart';

// reducer หน้าที่รับ state มา อัพเดทและ return ออก
@immutable
class ProfileState {
  final Map<String, dynamic> profile;

  ProfileState(
      {this.profile = const {
        'email': 'j@mail.com',
        'name': 'j',
        'role': 'member'
      }
      }
      // {this.profile}
      );

  ProfileState copyWith({Map<String, dynamic> profile}) {
    return ProfileState(profile: profile ?? this.profile);
  }
}

ProfileState profileReducer(ProfileState state, dynamic action) {
  if (action is GetProfileAction) {
    return state.copyWith(profile: action.profileState.profile);
  }
  return state;
}
