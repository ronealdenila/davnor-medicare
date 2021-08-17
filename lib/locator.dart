import 'package:davnor_medicare/core/services/authentication_service.dart';
import 'package:get_it/get_it.dart';

//Why I implemented this (R):
//https://www.youtube.com/watch?v=vBT-FhgMaWM
//"As your App grows, at some point you will need to put your app's logic
// in classes that are separated from your Widgets. Keeping your widgets 
//from having direct dependencies makes your code better organized and 
//easier to test and maintain."

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
}
