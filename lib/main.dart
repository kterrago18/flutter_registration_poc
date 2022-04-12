import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flexicar_registration_poc/bloc/auth/authbloc_bloc.dart';
import 'package:flutter_flexicar_registration_poc/constant/user_type_constant.dart';
import 'package:flutter_flexicar_registration_poc/models/user_type.dart';

import 'utils/enums.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Palatino'),
        home: const MyHomePage(
          title: 'Home',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum checkValue { selected, notSelected }

class _MyHomePageState extends State<MyHomePage> {
  bool _checkvalue = false;

  UserType _selectedUserType = UserTypeConstant.personal;

  final _fromKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration POC'),
      ),
      body: BlocListener<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          if (state.appStatus == AppStatus.idle) {
            _alertDialog(context, state.responseBody, state.responseStatusCode);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _fromKey,
              child: Column(
                children: [
                  RadioListTile(
                    value: UserTypeConstant.personal,
                    groupValue: _selectedUserType,
                    onChanged: (UserType? val) {
                      setState(() {
                        _selectedUserType = val!;
                      });
                    },
                    title: Text(UserTypeConstant.personal.typeName),
                  ),
                  RadioListTile(
                    value: UserTypeConstant.business,
                    groupValue: _selectedUserType,
                    onChanged: (UserType? val) {
                      setState(() {
                        _selectedUserType = val!;
                      });
                    },
                    title: Text(UserTypeConstant.business.typeName),
                  ),
                  RadioListTile(
                    value: UserTypeConstant.student,
                    groupValue: _selectedUserType,
                    onChanged: (UserType? val) {
                      setState(() {
                        _selectedUserType = val!;
                      });
                    },
                    title: Text(UserTypeConstant.student.typeName),
                  ),
                  CustomTextfield(
                    controller: _firstNameController,
                    label: 'First Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  CustomTextfield(
                    controller: _lastNameController,
                    label: 'Last Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  CustomTextfield(
                    controller: _emailAddressController,
                    label: 'Email Address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return 'Incorrect email format';
                      }
                      return null;
                    },
                  ),
                  CustomTextfield(
                    controller: _passwordController,
                    label: 'Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is needed';
                      }

                      if (value.length < 8) {
                        return 'Password must be 8 character and above.';
                      }
                      return null;
                    },
                  ),
                  CustomTextfield(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Verified your password';
                      }

                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        return 'Password not match';
                      }
                      return null;
                    },
                  ),
                  CustomTextfield(
                    controller: _contactController,
                    keyboardtype: TextInputType.number,
                    inputFormat: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    label: 'Contact Number',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Contact Number is needed';
                      }
                      return null;
                    },
                  ),
                  CustomTextfield(
                    controller: _countryController,
                    label: "Country",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Country is needed.';
                      }
                      return null;
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: CheckboxListTile(
                      title: const Text('Subscribe to our news and updates'),
                      value: _checkvalue,
                      onChanged: (val) {
                        setState(() {
                          _checkvalue = val!;
                        });
                      },
                    ),
                  ),
                  BlocBuilder<AuthBloc, AuthBlocState>(
                    builder: (context, state) {
                      return state.appStatus == AppStatus.idle
                          ? ElevatedButton(
                              onPressed: () {
                                if (_fromKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                        RegistrationSubmitted(
                                          type: _selectedUserType.id,
                                          lastname: _lastNameController.text,
                                          firstname: _firstNameController.text,
                                          email: _emailAddressController.text,
                                          password: _passwordController.text,
                                          confirmPassword:
                                              _confirmPasswordController.text,
                                          contact: _contactController.text,
                                          country: _countryController.text,
                                          isMailSubscriber: _checkvalue ? 1 : 0,
                                        ),
                                      );
                                }
                                print('## ElevationButtonPressed');
                              },
                              child: const Text("Register"),
                            )
                          : const CircularProgressIndicator();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _alertDialog(
      BuildContext context, String? responseBody, int? statusCode) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Status Code: $statusCode'),
            content: SingleChildScrollView(
                child: Text(responseBody ?? 'No Response')),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back')),
              TextButton(
                  onPressed: () {},
                  child: const Text('Everythings Looks Good.')),
            ],
          );
        });
  }
}

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {Key? key,
      required this.controller,
      required this.label,
      this.validator,
      this.keyboardtype,
      this.inputFormat})
      : super(key: key);
  final TextEditingController controller;
  final String label;
  final String? Function(String? value)? validator;
  final TextInputType? keyboardtype;
  final List<TextInputFormatter>? inputFormat;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            label: Text(label), contentPadding: const EdgeInsets.all(20.0)),
        validator: validator,
        keyboardType: keyboardtype,
        inputFormatters: inputFormat,
      ),
    );
  }
}
