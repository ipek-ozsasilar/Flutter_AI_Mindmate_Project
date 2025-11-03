import 'package:flutter_mindmate_project/products/services/firestore_service.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_mindmate_project/products/services/image_service.dart';


final getIt = GetIt.instance;

void setupLocator() {
  // Singleton olarak kaydet Lazy singleton — sadece ihtiyaç olduğunda oluşturulur
  //Artık herhangi bir yerden getIt aracılığıyla nesneye erişebilirsin final apiService = getIt<ApiService>();
  //getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  // Firestore service - mesaj veritabanı işlemleri
  getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());
  getIt.registerLazySingleton<ImageService>(() => ImageService());
}
