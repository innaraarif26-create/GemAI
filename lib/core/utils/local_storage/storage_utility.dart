import 'package:get_storage/get_storage.dart';

class AppLocalStorage
{
  AppLocalStorage._();

  static final AppLocalStorage _instance = AppLocalStorage._internal();
   factory AppLocalStorage()
   {
     return _instance;
   }

   AppLocalStorage._internal();
   final _storage = GetStorage();

   Future<void> saveData<T>(String key, T value) async
   {
     await _storage.write(key, value);
   }
   T? readData<T>(String key)
   {
     return _storage.read<T>(key);
   }

   Future<void> removeData(String key) async
   {
     await _storage.read(key);
   }

   Future <void> clearAll() async
   {
     await _storage.erase();
   }
}