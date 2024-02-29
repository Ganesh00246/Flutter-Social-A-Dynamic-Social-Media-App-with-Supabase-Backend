import 'package:clone/controllers/auth_controller.dart';
import 'package:clone/routes/routes_name.dart';
import 'package:clone/widgets/auth_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(
      text: '');
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());
  final AuthController controller = Get.put(AuthController());

  void submit() {
    if (_form.currentState!.validate()) {
      authController.login(emailController.text, passwordController.text);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png', width: 60, height: 60,),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Login', style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),),
                          Text('Welcome Back'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    AuthInput(
                      controller: emailController,
                      label: 'Email',
                      hintText: 'Enter your email',
                      validatorCallback: ValidationBuilder().required()
                          .email()
                          .build(),

                    ),
                    const SizedBox(height: 20,),
                    AuthInput(
                      controller: passwordController,
                      label: 'Password',
                      hintText: 'Enter your password',
                      isPasswordField: true,
                      validatorCallback: ValidationBuilder().required().build(),
                    ),
                    const SizedBox(height: 20,),
                    Obx(() {
                      return ElevatedButton(
                        onPressed: () {
                          submit();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            controller.registerLoading.value?"Processing":
                            "Login", style: TextStyle(fontSize: 16),),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          minimumSize: MaterialStateProperty.all(
                              const Size.fromHeight(40)),
                        ),
                      );
                    }),
                    const SizedBox(height: 20,),
                    Text.rich(TextSpan(
                        children: [
                          TextSpan(
                              text: " Sign up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ), recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(RouteNames.register)
                          ),
                        ], text: "Don't have an account ?"
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
