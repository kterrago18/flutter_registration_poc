import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_flexicar_registration_poc/data/provider/auth_registration_api.dart';
import 'package:http/http.dart';

import '../../utils/enums.dart';

part 'authbloc_event.dart';
part 'authbloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBloc() : super(const AuthBlocState()) {
    on<RegistrationSubmitted>(_mapRegistrationSubmittedEventToState);
    on<LastNameChanged>(
      (event, emit) => LastNameChanged(lastname: event.lastname),
    );
    on<FirstNameChanged>(
      (event, emit) => FirstNameChanged(firstname: event.firstname),
    );
    on<UserEmailChanged>(
      (event, emit) => UserEmailChanged(email: event.email),
    );
  }

  FutureOr<void> _mapRegistrationSubmittedEventToState(
      RegistrationSubmitted event, Emitter<AuthBlocState> emit) async {
    print('## _mapRegistrationSubmittedEventToState');

    emit(state.copyWith(appStatus: AppStatus.busy));

    try {
      final response = await AuthRegistrarionApi().submitRegistration(
          event.type,
          event.lastname,
          event.firstname,
          event.email,
          event.password,
          event.confirmPassword,
          event.contact,
          event.country,
          event.isMailSubscriber);
      if (response.statusCode == 201) {
        emit(state.copyWith(authStatus: AuthStatus.success));
        print('## registration successful');
      }
      if (response.statusCode == 422) {
        emit(state.copyWith(authStatus: AuthStatus.failure));
        print('## email already exist');
      }

      emit(state.copyWith(
          responseBody: response.body,
          responseStatusCode: response.statusCode));
    } catch (_) {
      emit(state.copyWith(authStatus: AuthStatus.failure));
    }

    emit(state.copyWith(appStatus: AppStatus.idle));
  }
}
