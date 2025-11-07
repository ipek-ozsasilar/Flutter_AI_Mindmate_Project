enum ErrorStringsEnum {
  internetConnectionError('dont have internet connection'),
  internetConnectionSuccess('internet connection established'),
  emailAndPasswordError('email and password are required'),
  messageGetSuccess('message get successful'),
  emailEmptyError('email is empty'),
  passwordEmptyError('password is empty'),
  loginFailed('login failed'),
  aiResponseSuccess('ai response successful'),
  loginSuccess('login successful'),
  invalidEmailError('invalid email'),
  invalidEmailFormatError('invalid email format'),
  userDisabledError('user disabled'),
  speechToTextInitializationError('speech-to-text initialization error'),
  userNotLoggedIn('user not logged in'),
  userNotFoundError('user not found'),
  wrongPasswordError('wrong password'),

  invalidCredentialError('invalid credential'),
  cannotUpdateGoogleEmail('cannot update email for google accounts'),
  uploadImageFailed('upload image failed'),
  tooManyRequestsError('too many requests'),
  unexpectedError('unexpected error'),
  cannotUpdateGooglePassword('cannot update password for google accounts'),
  updatePasswordFailed('update password failed'),

  passwordLengthError('password must be at least 6 characters long'),
  passwordDigitsOnlyError('password must contain only digits'),
  googleLoginCanceled('google login canceled'),
  passwordResetEmailSent('password reset email sent'),
  messageGetError('message get error'),
  fullNameEmptyError('full name is empty'),
  messageAddError('message add error'),
  createAccountSuccess('create account successful'),
  createAccountFailed('create account failed'),
  emailAlreadyInUseError('email already in use'),
  weakPasswordError('weak password'),
  operationNotAllowedError('operation not allowed'),
  urlLaunchError('url launch error'),
  passwordResetEmailSentFailed('password reset email sent failed');

  final String value;
  const ErrorStringsEnum(this.value);
}
