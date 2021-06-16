abstract class FailureShortly implements Exception {
  final String message;
  FailureShortly({required this.message});
}

class NoUrlError implements FailureShortly {
  @override
  String get message => 'No URL specified.';
}

class InvalidUrlError implements FailureShortly {
  @override
  String get message => 'Invalid URL submitted.';
}

class RateLimitError implements FailureShortly {
  @override
  String get message => 'Rate limit reached. Wait a second and try again.';
}

class BlockedIpError implements FailureShortly {
  @override
  String get message => 'IP-Address has been blocked because of violating our terms of service.';
}

class ShrtcodeUseError implements FailureShortly {
  @override
  String get message => 'Shrtcode code already taken/in use.';
}

class UnknowError implements FailureShortly {
  @override
  String get message => 'Unknown error.';
}

class NoCodeError implements FailureShortly {
  @override
  String get message => 'No code specified.';
}

class InvalidCodeError implements FailureShortly {
  @override
  String get message => 'Invalid code error.';
}

class MissingRequiredParametersError implements FailureShortly {
  @override
  String get message => 'Missing required parameters.';
}

class DisallowedLinkError implements FailureShortly {
  @override
  String get message => 'Trying to shorten a disallowed Link.';
}

class DatasourceError implements FailureShortly {
  @override
  String get message => 'Datasource error. Try again!';
}
