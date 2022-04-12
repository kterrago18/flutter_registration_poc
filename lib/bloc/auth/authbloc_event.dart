part of 'authbloc_bloc.dart';

abstract class AuthBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FirstNameChanged extends AuthBlocEvent {
  final String firstname;
  FirstNameChanged({required this.firstname});
}

class LastNameChanged extends AuthBlocEvent {
  final String lastname;
  LastNameChanged({required this.lastname});
}

class UserEmailChanged extends AuthBlocEvent {
  final String email;
  UserEmailChanged({required this.email});
}

class RegistrationSubmitted extends AuthBlocEvent {
  final int type;
  final String lastname;
  final String firstname;
  final String email;
  final String password;
  final String confirmPassword;
  final String contact;
  final String country;
  final int isMailSubscriber;

  RegistrationSubmitted(
      {required this.type,
      required this.lastname,
      required this.firstname,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.contact,
      required this.country,
      required this.isMailSubscriber});
}
