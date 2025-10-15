import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Singleton olarak kaydet Lazy singleton — sadece ihtiyaç olduğunda oluşturulur
  //Artık herhangi bir yerden getIt aracılığıyla nesneye erişebilirsin final apiService = getIt<ApiService>();
  //getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  

}


