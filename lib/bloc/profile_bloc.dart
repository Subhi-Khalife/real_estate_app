import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate_app/Api/get_profile_api.dart';
import 'package:real_estate_app/model/get_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if(event is GetProfileUserEvent)
      {
        yield LoadingDataProfile();
        GetProfile getProfile = await ProfileApi.getProfile();
        if(getProfile.status != "OK")
          yield InvalidFetchState();
        else
        {
          print("get Profile $getProfile");
          yield FetchProfile(getProfile);
        }
      }
  }
}
