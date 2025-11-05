/// Firestore collection isimleri
enum FirestoreCollectionsEnum {
  messages('Messages'),
  images('Image'),
  notifications('Notification');

  final String value;
  const FirestoreCollectionsEnum(this.value);
}
