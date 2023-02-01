import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-Screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final authServices = AuthService();
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signUpUser() {
    authServices.signUpUser(
      context: context,
      email: _emailController.text,
      name: _nameController.text,
      password: _passwordController.text,
    );
  }

  void signInUser() {
    authServices.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const Text(
            'Welcome',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          ListTile(
            tileColor: _auth == Auth.signup
                ? GlobalVariables.backgroundColor
                : GlobalVariables.greyBackgroundCOlor,
            title: const Text(
              'Create Account',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Radio(
              value: Auth.signup,
              groupValue: _auth,
              onChanged: (Auth? val) => {
                setState(() {
                  _auth = val!;
                })
              },
              activeColor: GlobalVariables.secondaryColor,
            ),
          ),
          if (_auth == Auth.signup)
            Container(
              color: GlobalVariables.backgroundColor,
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _signUpFormKey,
                child: Column(children: [
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Name',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Sign Up',
                    onTap: () {
                      if (_signUpFormKey.currentState!.validate()) {
                        signUpUser();
                      }
                    },
                  ),
                ]),
              ),
            ),
          ListTile(
            tileColor: _auth == Auth.signin
                ? GlobalVariables.backgroundColor
                : GlobalVariables.greyBackgroundCOlor,
            title: const Text(
              'Sign In',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Radio(
              value: Auth.signin,
              groupValue: _auth,
              onChanged: (Auth? val) => {
                setState(() {
                  _auth = val!;
                })
              },
              activeColor: GlobalVariables.secondaryColor,
            ),
          ),
          if (_auth == Auth.signin)
            Container(
              color: GlobalVariables.backgroundColor,
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _signInFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                        text: 'Sign In',
                        onTap: () {
                          if (_signInFormKey.currentState!.validate()) {
                            signInUser();
                          }
                        }),
                  ],
                ),
              ),
            ),
        ]),
      )),
    );
  }
}
