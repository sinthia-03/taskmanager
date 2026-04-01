import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/data/models/user_model.dart';

class AuthController {
static String _accessTokenKey = 'token';
static String _userModelKey= 'user-data';
static final Logger _logger = Logger();

static String ? accessToken;
static UserModel ? userModel;

static Future saveUserData(UserModel model,String token)async
{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString(_accessTokenKey, token);
 await sharedPreferences.setString(_userModelKey, jsonEncode(model.toJson()));
  accessToken = token;
  userModel = model;
  _logger.i(accessToken);
  _logger.i(userModel);

}

static Future getUserData()async
{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String ? token = sharedPreferences.getString(_accessTokenKey);
  if(token != null )
    {
      accessToken = token;
      String ? userData = sharedPreferences.getString(_userModelKey);
      userModel = UserModel.fromJson(jsonDecode(userData!));
    }
  _logger.i(accessToken);
  _logger.i(userModel);

}

static Future<bool> isUserLoggIn()async
{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String ? token = sharedPreferences.getString(_accessTokenKey);
  return token != null;

}

}