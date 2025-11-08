enum ErrorStringsEnum {
  internetConnectionError('Dont have internet connection'),
  internetConnectionSuccess('Internet connection established'),
  emailAndPasswordError('Email and password are required'),
  messageGetSuccess('Message get successful'),
  emailEmptyError('Email is empty'),
  passwordEmptyError('Password is empty'),
  loginFailed('Login failed'),
  aiResponseSuccess('Ai response successful'),
  loginSuccess('Login successful'),
  invalidEmailError('Invalid email'),
  invalidEmailFormatError('Invalid email format'),
  userDisabledError('User disabled'),
  speechToTextInitializationError('Speech-to-text initialization error'),
  userNotLoggedIn('User not logged in'),
  userNotFoundError('User not found'),
  wrongPasswordError('Wrong password'),

  invalidCredentialError('Invalid credential'),
  cannotUpdateGoogleEmail('Cannot update email for google accounts'),
  uploadImageFailed('Upload image failed'),
  tooManyRequestsError('Too many requests'),
  unexpectedError('Unexpected error'),
  cannotUpdateGooglePassword('Cannot update password for google accounts'),
  updatePasswordFailed('Update password failed'),

  passwordLengthError('Password must be at least 6 characters long'),
  passwordDigitsOnlyError('Password must contain only digits'),
  googleLoginCanceled('Google login canceled'),
  passwordResetEmailSent('Password reset email sent'),
  messageGetError('Message get error'),
  fullNameEmptyError('Full name is empty'),
  messageAddError('Message add error'),
  createAccountSuccess('Create account successful'),
  createAccountFailed('Create account failed'),
  emailAlreadyInUseError('Email already in use'),
  weakPasswordError('Weak password'),
  operationNotAllowedError('Operation not allowed'),
  urlLaunchError('Url launch error'),
  passwordResetEmailSentFailed('Password reset email sent failed');

  final String value;
  const ErrorStringsEnum(this.value);
}
