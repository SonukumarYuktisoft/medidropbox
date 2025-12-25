part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.mess = '',
    this.profileStatus = ApiStatus.initial,
    this.profileData,
  });

  final String mess;
  final ApiStatus profileStatus;
  final GerProfile? profileData;

  ProfileState copyWith({
    String? mess,
    ApiStatus? profileStatus,
    GerProfile? profileData,
  }) {
    return ProfileState(
      mess: mess ?? this.mess,
      profileStatus: profileStatus ?? this.profileStatus,
      profileData: profileData ?? this.profileData,
    );
  }

  @override
  List<Object?> get props => [mess, profileStatus, profileData];
}
