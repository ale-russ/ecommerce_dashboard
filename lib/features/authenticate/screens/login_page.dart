import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ecommerce_dashboard/features/authenticate/providers/isObuscre_provider.dart';
import 'package:ecommerce_dashboard/features/authenticate/screens/registration.dart';
import 'package:go_router/go_router.dart';

import '../../constants/constants.dart';
import '../controller/login_controller.dart';
import '../providers/auth_state_change_provider.dart';
import '../widgets/email_password_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var isObscured = ref.watch(isObscureProvider);

    // ref.listen<LoadStatus>(loginControllerProvider, (previous, state) {
    //   log('state: $state');
    //   if (state == LoadStatus.error) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: const Text('Something went wrong...'),
    //     ));
    //   } else if (state == LoadStatus.loading) {
    //     const CircularProgressIndicator(
    //       color: Colors.amber,
    //     );
    //   }
    // });

    return Scaffold(
      backgroundColor: const Color.fromRGBO(22, 16, 75, 0.6),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: secondaryColor,
        title: const Text('Login'),
      ),
      body: Container(
        color: bgColor,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmailPasswordFields(
                hint: 'email',
                controller: emailController,
                validator: (email) {
                  var isValid = EmailValidator.validate(email!);
                  if (isValid) return null;
                  return 'invalid email';
                },
              ),
              EmailPasswordFields(
                controller: passwordController,
                obscureText: isObscured,
                hint: 'password',
                validator: (String? password) {
                  if (password == null || password.isEmpty) {
                    return 'enter valid password';
                  }
                  return null;
                },
                icon: IconButton(
                  icon: Icon(
                    !isObscured
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () =>
                      ref.read(isObscureProvider.notifier).state = !isObscured,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    var isValid = _formKey.currentState?.validate() ?? false;
                    if (isValid) {
                      ref
                          .read(loginControllerProvider.notifier)
                          .login(emailController.text, passwordController.text)
                          .then((value) {
                        ref.read(loggedIn.notifier).setLogin(value);
                      });
                    }
                  },
                  child: const Text('Sign In'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/register');
                  },
                  child: const Text(
                    'Create new account',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                  onPressed: () {
                    ref.read(loginControllerProvider.notifier).googleSignIn();
                  },
                  icon: SvgPicture.asset(
                    'assets/icon_google.svg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
