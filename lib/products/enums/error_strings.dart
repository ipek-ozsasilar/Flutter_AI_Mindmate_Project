enum ErrorStringsEnum {
  internetConnectionError('dont have internet connection'),
  emailAndPasswordError('email and password are required'),
  emailEmptyError('email is empty'),
  passwordEmptyError('password is empty'),
  loginFailed('login failed'),
  loginSuccess('login successful'),
  invalidEmailError('invalid email'),
  userDisabledError('user disabled'),
  userNotFoundError('user not found'),
  wrongPasswordError('wrong password'),
  invalidCredentialError('invalid credential'),
  tooManyRequestsError('too many requests'),
  unexpectedError('unexpected error'),
  passwordLengthError('password must be at least 6 characters long'),
  googleLoginCanceled('google login canceled'),
  passwordResetEmailSent('password reset email sent');

  final String value;
  const ErrorStringsEnum(this.value);
}