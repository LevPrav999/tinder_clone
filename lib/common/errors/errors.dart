abstract class Failture implements Exception{
  String get message;

  
}

class NotAutomaticRetrieved implements Failture{
  final String verificationId;
  @override
  final String message;

  NotAutomaticRetrieved(this.verificationId, this.message);
}

class ErrorLoginPhone implements Failture{
  @override
  final String message;

  ErrorLoginPhone(this.message);
}

class FirestoreError implements Failture{
  @override
  final String message;

  FirestoreError(this.message);
}

class TagsUnselected implements Failture{
  @override
  final String message;

  TagsUnselected(this.message);
}