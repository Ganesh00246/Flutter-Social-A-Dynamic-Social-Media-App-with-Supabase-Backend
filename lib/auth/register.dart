import 'package:clone/controllers/auth_controller.dart';
import 'package:clone/routes/routes_name.dart';
import 'package:clone/widgets/auth_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(
      text: '');
  final TextEditingController cpasswordController = TextEditingController(
      text: '');
  final TextEditingController nameController = TextEditingController(text: '');
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final AuthController controller = Get.put(AuthController());

  void submit() {
    if (_form.currentState!.validate()) {
      controller.register(
          nameController.text, emailController.text, passwordController.text);
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    nameController.dispose();
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
                          Text('Register', style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),),
                          Text('Welcome to the virtual world'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    AuthInput(
                      controller: nameController,
                      label: 'Username',
                      hintText: 'Enter Username',
                      validatorCallback: ValidationBuilder().required()
                          .minLength(3).maxLength(50)
                          .build(),
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
                      validatorCallback: ValidationBuilder().required()
                          .minLength(6).maxLength(50)
                          .build(),
                    ),
                    const SizedBox(height: 20,),
                    AuthInput(
                      controller: cpasswordController,
                      label: 'Conform Password',
                      hintText: 'Conform your password',
                      validatorCallback: (arg) {
                        if (passwordController.text != arg) {
                          return "Conform password not matched";
                        }
                        return null;
                      },
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
                            "Sign up", style: TextStyle(fontSize: 16),),
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
                              text: " Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ), recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(RouteNames.login)
                          ),
                        ], text: "Aready have an account ?"
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
