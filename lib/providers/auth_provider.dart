import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/api_response.dart';
import '../data/models/user_model.dart';
import '../services/api_caller.dart';
import '../utilits/urls.dart';

class AuthProvider extends ChangeNotifier{
  static String _accessTokenKey = 'token';
  static String _userModelKey= 'user-data';
  static final Logger _logger = Logger();
   String  ? errorMwssage;
  bool isLoading = false;
  bool isLoggedIn= false;


  static String ? accessToken;
  static UserModel ? userModel;
  Future saveUserData(UserModel model,String token)async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    await sharedPreferences.setString(_userModelKey, jsonEncode(model.toJson()));
    accessToken = token;
    userModel = model;
    isLoggedIn = true;
    _logger.i(accessToken);
    _logger.i(userModel);
    notifyListeners();


  }
   Future getUserData()async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String ? token = sharedPreferences.getString(_accessTokenKey);
    if(token!=null){
      accessToken = token;
      String ? userData = sharedPreferences.getString(_userModelKey);
      userModel = UserModel.fromJson(jsonDecode(userData!));
      isLoggedIn = true;
    }
    else{
      isLoggedIn = false;
    }
    _logger.i(token);
    _logger.i(userModel);
    notifyListeners();

  }

   Future<bool> isUserLoggIn()async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String ? token = sharedPreferences.getString(_accessTokenKey);
    return token != null;

  }
  Future<void> updateUserData(UserModel model)async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userModelKey, jsonEncode(model.toJson()));
    notifyListeners();
  }
   Future<void> cleanUserData(UserModel model)async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    notifyListeners();
  }

  _setLoading(bool value){
    isLoading = value;
    notifyListeners();
  }

  Future <bool>SignIn(String email, String password) async{
    Map<String,dynamic>requestBody =
    {
      'email': email,
      'password': password,

    };
    _setLoading(true);

    final ApiResponse response = await ApiCaller.PostRequest(
      URL: Urls.loginUrl,
      body: requestBody,
    );

    _setLoading(false);

    if(response.isSuccess) {
      UserModel model = UserModel.fromJson(response.responseData['data']);
      String accessToken = response.responseData['token'];
      await saveUserData(model, accessToken);
      return true;
    }else{
      errorMwssage = response.responseData.toString();
      notifyListeners();
      return false;
    }
  }


}