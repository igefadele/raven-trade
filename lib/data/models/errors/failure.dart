abstract class Failure {
  String get title;
  String get message;
}

class ModuleFailure implements Failure {
  String failureMessage;
  String failureTitle;
  ModuleFailure({
    required this.failureMessage,
    required this.failureTitle,
  });
  @override
  String get message => failureMessage;

  @override
  String get title => failureTitle;
}
