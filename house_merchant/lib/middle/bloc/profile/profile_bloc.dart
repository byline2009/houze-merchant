import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/middle/bloc/profile/index.dart';
import 'package:house_merchant/middle/repository/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository profileRepository = ProfileRepository();

  ProfileBloc(ProfileState initialState) : super(initialState) {
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoading());

      try {
        final result = await ProfileRepository().getProfile();
        emit(ProfileGetSuccessful(result: result));
      } catch (error) {
        emit(ProfileFailure(error: error.toString()));
      }
    });
  }
}
