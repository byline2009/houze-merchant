import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/middle/bloc/profile/index.dart';
import 'package:house_merchant/middle/repository/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository profileRepository = ProfileRepository();

  ProfileBloc();

  ProfileState get initialState => ProfileInitial();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is GetProfileEvent) {
      yield ProfileLoading();

      try {
        final result = await ProfileRepository().getProfile();
        yield ProfileGetSuccessful(result: result);
      } catch (error) {
        yield ProfileFailure(error: error.toString());
      }
    }
  }
}
