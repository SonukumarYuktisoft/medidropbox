// lib/app/auth/bloc/profile_image_cubit.dart
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// States
abstract class ProfileImageState extends Equatable {
  const ProfileImageState();

  @override
  List<Object?> get props => [];
}

class ProfileImageInitial extends ProfileImageState {}

class ProfileImageLoading extends ProfileImageState {}

class ProfileImageSelected extends ProfileImageState {
  final File imageFile;

  const ProfileImageSelected(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class ProfileImageError extends ProfileImageState {
  final String message;

  const ProfileImageError(this.message);

  @override
  List<Object?> get props => [message];
}

// Cubit
class ProfileImageCubit extends Cubit<ProfileImageState> {
  ProfileImageCubit() : super(ProfileImageInitial());

  void selectImage(File imageFile) {
    try {
      emit(ProfileImageSelected(imageFile));
    } catch (e) {
      emit(ProfileImageError('Failed to select image: ${e.toString()}'));
    }
  }

  void removeImage() {
    emit(ProfileImageInitial());
  }

  void setInitialImage(File? imageFile) {
    if (imageFile != null) {
      emit(ProfileImageSelected(imageFile));
    } else {
      emit(ProfileImageInitial());
    }
  }

  File? getSelectedImage() {
    if (state is ProfileImageSelected) {
      return (state as ProfileImageSelected).imageFile;
    }
    return null;
  }
}