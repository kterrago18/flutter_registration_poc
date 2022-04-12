part of 'authbloc_bloc.dart';

class AuthBlocState extends Equatable {
  final AuthStatus authStatus;
  final AppStatus appStatus;
  final String responseBody;
  final int responseStatusCode;

  final int type;
  final String lastName;
  final String firstName;
  final String email;
  final String password;
  final String password2;
  final String contact;
  final String country;

  bool get isValidLastName => lastName.isNotEmpty;
  bool get isValidfirstName => lastName.isNotEmpty;
  bool get isValidEmail => EmailValidator.validate(email);
  bool get isValidPassword => password.isNotEmpty;
  bool get passwordIsMatch => password2.isNotEmpty && password2 == password;
  bool get isValidContact => contact.isNotEmpty;
  bool get isValidCountry => country.isNotEmpty;

  // bool validateEmail(String? value) {
  //   String pattern =
  //       r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
  //       r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
  //       r"{0,253}[a-zA-Z0-9]?)*$";
  //   RegExp regex = RegExp(pattern);
  //   if (value == null || value.isEmpty || !regex.hasMatch(value)) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  const AuthBlocState(
      {this.type = 0,
      this.lastName = '',
      this.firstName = '',
      this.email = '',
      this.password = '',
      this.password2 = '',
      this.contact = '',
      this.country = '',
      this.responseBody = '',
      this.responseStatusCode = 0,
      this.appStatus = AppStatus.idle,
      this.authStatus = AuthStatus.initial});

  @override
  List<Object> get props => [
        authStatus,
        appStatus,
        responseBody,
        responseStatusCode,
        type,
        lastName,
        firstName,
        email,
        password,
        password2,
        contact,
        country
      ];

  AuthBlocState copyWith(
      {AuthStatus? authStatus,
      AppStatus? appStatus,
      String? responseBody,
      int? responseStatusCode,
      int? type,
      String? lastName,
      String? firstName,
      String? email,
      String? password,
      String? password2,
      String? contact,
      String? country}) {
    return AuthBlocState(
        authStatus: authStatus ?? this.authStatus,
        appStatus: appStatus ?? this.appStatus,
        responseBody: responseBody ?? this.responseBody,
        responseStatusCode: responseStatusCode ?? this.responseStatusCode,
        type: type ?? this.type,
        lastName: lastName ?? this.lastName,
        firstName: firstName ?? this.firstName,
        email: email ?? this.email,
        password: password ?? this.password,
        password2: password2 ?? this.password2,
        contact: contact ?? this.contact,
        country: country ?? this.country);
  }
}
