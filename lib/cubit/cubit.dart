import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meal_applicaion/cubit/states.dart';

class TestLoginCubit extends Cubit<TestPostLoginStates> {
  TestLoginCubit() : super(InitialTestPostLoginStates());

  static TestLoginCubit get(context) => BlocProvider.of(context);

  Future<void> loginIn(email, password) async {
    emit(LoadingTestPostLoginStates());
    const url = 'https://student.valuxapps.com/api/login';
    await http.post(Uri.parse(url),body: json.encode({
          "email": email,
          "password": password,
        }),headers: {
          "lang": "ar",
          "Content-Type": "application/json",
        }).then((value) {
      emit(SuccessTestPostLoginStates());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorTestPostLoginStates());
    });
  }
}
