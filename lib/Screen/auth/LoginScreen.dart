import 'package:flutter/material.dart';
import 'package:project_setup/Providers/AuthProvider.dart';
import 'package:project_setup/Utils/ImportFile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> obscure = ValueNotifier<bool>(false);
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Enter Email"),
                validator: (val) {
                  if (val == '') {
                    return 'Please enter valid email.';
                  }
                },
              ),
              ValueListenableBuilder(
                  valueListenable: obscure,
                  builder: (context, value, child) {
                    return TextFormField(
                      obscureText: obscure.value,
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: "Enter password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                obscure.value = !obscure.value;
                              },
                              icon: Icon(!obscure.value
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                      validator: (val) {
                        if (val == '') {
                          return 'Please enter password.';
                        }
                      },
                    );
                  }),
              SizedBox(height: 50),
              Consumer<AuthProvider>(builder: (context, value, child) {
                return CommonWidgets.commonElevatedButton(
                    onPressed: () {
                      if(formKey.currentState!=null)
                      if(formKey.currentState!.validate()){
                        value.clickOnLogin(emailController.text,
                            passwordController.text,context);
                      }

                    },
                    child: value.loading?CircularProgressIndicator(color: Colors.white,)
                        :Text(
                      "Login",
                      style: TextStyle(fontSize: 14),
                    ),
                    context: context);
              })
            ],
          ),
        ),
      ),
    );
  }
}
