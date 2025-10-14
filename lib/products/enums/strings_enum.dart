import 'package:flutter/material.dart';

enum StringsEnum {
  splashTitle('Manage your Day with Mindmate'),
  startText('Let’s Start'),
  welcomeBack('Welcome Back!'),
  emailEmailAddress('Email Address'),
  passwordPassword('Password'),
  forgotPassword('Forgot Password?'),
  orContinueWith('Or continue with'),
  google('Google'),
  logIn('Log In'),
  dontHaveAnAccount('Don’t have an account?'),
  signUp('Sign Up'),
  createYourAccount('Create your account'),
  fullName('Full Name'),
  alreadyHaveAnAccount('Already have an account?'),
  privacyPolicy('I have read & agreed to Mindmate Privacy Policy,Terms & Condition',),
  notifications('Notifications'),
  history('History'),
  profile('Profile'),
  logout('Logout');

  final String value;
  const StringsEnum(this.value);
}
