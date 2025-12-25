part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class OnGetProfile extends ProfileEvent {}

class OnUpdateProfile extends ProfileEvent {
  final Map<String, dynamic> data;

  const OnUpdateProfile({required this.data});

  @override
  List<Object?> get props => [data];
}
