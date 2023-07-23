abstract class Failture implements Exception{
  String get message;

  
}


class NotAutomaticRetrieved implements Failture{
  final String verificationId;
  final String message;

  NotAutomaticRetrieved(this.verificationId, this.message);
}

class ErrorLoginPhone implements Failture{
  final String message;

  ErrorLoginPhone(this.message);
}

class FirestoreError implements Failture{
  final String message;

  FirestoreError(this.message);
}