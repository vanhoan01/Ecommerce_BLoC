import 'package:ecommerce_bloc/blocs/blocs.dart';
// import 'package:ecommerce_bloc/config/auth.dart';
import 'package:ecommerce_bloc/widgets/widgets.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  // String? email;
  // String? password;
  // bool? remember = false;
  // final List<String?> errors = [];
  bool _passwordVisible = true;

  // bool isLogin = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  // Future<bool> signInWithEmailAndPassword() async {
  //   try {
  //     await Auth().signInWithEmailAndPassword(
  //       email: _controllerEmail.text,
  //       password: _controllerPassword.text,
  //     );
  //     return true;
  //   } on FirebaseAuthException catch (e) {
  //     addError(error: e.message);
  //     return false;
  //   }
  // }

  // Future<void> createUserWithEmailAndPassword() async {
  //   try {
  //     await Auth().createUserWithEmailAndPassword(
  //       email: _controllerEmail.text,
  //       password: _controllerPassword.text,
  //     );
  //   } on FirebaseAuthException catch (e) {

  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is AuthLoaded) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                buildEmailFormField(),
                const SizedBox(height: 30),
                buildPasswordFormField(),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, '/forgot_password'),
                      child: Text(
                        "Quên mật khẩu?",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.blueAccent),
                      ),
                    )
                  ],
                ),
                FormError(errors: state.errors),
                const SizedBox(height: 20),
                DefaultButton(
                  text: "Đăng nhập",
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      // Navigator.pushNamed(context, '/');
                    }
                    try {
                      context.read<AuthBloc>().add(
                            Signin(
                              email: _controllerEmail.text.toString(),
                              password: _controllerPassword.text.toString(),
                            ),
                          );
                      Navigator.pushNamed(context, '/');
                    } catch (error) {
                      // ignore: avoid_print
                      print('failed');
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return const Text('Đã xảy ra sự cố');
        }
      },
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _controllerPassword,

      // onSaved: (newValue) => password = newValue,
      obscureText: _passwordVisible,
      onChanged: (value) {
        // if (value.isNotEmpty) {
        //   removeError(error: 'Vui lòng nhập mật khẩu của bạn');
        // } else if (value.length >= 8) {
        //   removeError(error: 'Mật khẩu quá ngắn');
        // }
        // return;
      },
      validator: (value) {
        return null;

        // if (value!.isEmpty) {
        //   addError(error: 'Vui lòng nhập mật khẩu của bạn');
        //   return "";
        // } else if (value.length < 8) {
        //   addError(error: 'Mật khẩu quá ngắn');
        //   return "";
        // }
        // return null;
      },
      decoration: InputDecoration(
        labelText: "Mật khẩu",
        hintText: "Nhập mật khẩu",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,

      // onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        // if (value.isNotEmpty) {
        //   removeError(error: 'Please Enter your email');
        // } else if (RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        //     .hasMatch(value)) {
        //   removeError(error: 'Please Enter Valid Email');
        // }
        // return;
      },
      validator: (value) {
        return null;

        // if (value!.isEmpty) {
        //   addError(error: 'Please Enter your email');
        //   return "";
        // } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        //     .hasMatch(value)) {
        //   addError(error: 'Please Enter Valid Email');
        //   return "";
        // }
        // return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Nhập email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
