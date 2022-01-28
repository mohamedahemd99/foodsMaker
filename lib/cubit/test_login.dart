import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_applicaion/cubit/states.dart';

import 'cubit.dart';

class TestLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => TestLoginCubit(),
      child: BlocConsumer<TestLoginCubit, TestPostLoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "LOGIN",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Login now browse our hot offers",
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30.0,),
                      MaterialButton(onPressed: () async{
                        // ignore: avoid_print
                        await TestLoginCubit.get(context).loginIn(emailController.text, passwordController.text);
                      },
                        color: Colors.red,
                        child: const Center(child: Text("Login"),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
