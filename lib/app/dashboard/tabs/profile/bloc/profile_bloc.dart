import 'dart:convert';

import 'package:medidropbox/app/models/profile/getprofile_model.dart';
import 'package:medidropbox/app/repository/profile/profile_repo.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo repo;

  ProfileBloc(this.repo) : super(const ProfileState()) {
    on<OnGetProfile>(_onGetProfile);
    on<OnUpdateProfile>(_onUpdateProfile); // ✅ ADD
  }

  // ================= GET PROFILE =================

  Future<void> _onGetProfile(
    OnGetProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(profileStatus: ApiStatus.loading));

    try {
      final res = await repo.getProfile();

      ApiResponseHandler.handle<GerProfile, ProfileState>(
        emit: emit,
        state: state,
        response: res,
        parser: (data) => gerProfileFromJson(jsonEncode(data)),
        onSuccess: (state, mess, data) => state.copyWith(
          profileStatus: ApiStatus.success,
          mess: mess,
          profileData: data,
        ),
        onError: (state, mess) =>
            state.copyWith(profileStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(state.copyWith(profileStatus: ApiStatus.error, mess: e.toString()));
    }
  }

  // ================= UPDATE PROFILE =================

  Future<void> _onUpdateProfile(
    OnUpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(profileStatus: ApiStatus.loading));

    try {
      final res = await repo.updateProfile(event.data); // ✅ payload pass

      ApiResponseHandler.handle<GerProfile, ProfileState>(
        emit: emit,
        state: state,
        response: res,
        parser: (data) => gerProfileFromJson(jsonEncode(data)),
        onSuccess: (state, mess, data) => state.copyWith(
          profileStatus: ApiStatus.success,
          mess: mess,
          profileData: data, // ✅ updated profile
        ),
        onError: (state, mess) =>
            state.copyWith(profileStatus: ApiStatus.error, mess: mess),
      );
    } catch (e) {
      emit(state.copyWith(profileStatus: ApiStatus.error, mess: e.toString()));
    }
  }
}
