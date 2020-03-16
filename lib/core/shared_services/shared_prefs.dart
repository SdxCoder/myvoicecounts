
import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefs {
  // SharedPrefs sharedPrefs;
  final SharedPreferences _preferences;

  SharedPrefs(this._preferences);

  

  // Future<void> _init() async {
    
  //   await getInstance();

  // }

  // Future<SharedPrefs> getInstance() async {
  //   // if(sharedPrefs == null){
  //   //   sharedPrefs = SharedPrefs();
  //   // }

  //   if(_preferences == null) {
  //     _preferences = await SharedPreferences.getInstance();
  //   }

  //  // return sharedPrefs;
  // }


  getFromDisk(String key){
    var value = _preferences.get(key);
    print('(TRACE: SharedPrefs:_getFromDisk)  key: $key value: $value');
    return value;
  }


  saveToDisk<T>(String key ,T content){

    
   print('(TRACE: SharedPrefs:_saveToDisk\n Object:_${T.runtimeType})  \nkey: $key \nvalue: $content');


    if(content is String){
      _preferences.setString(key, content);
    }

    if(content is bool){
      _preferences.setBool(key, content);
    }

    if(content is int){
      _preferences.setInt(key, content);
    }

     if(content is double){
      _preferences.setDouble(key, content);
    }

    if(content is List<String>){
      _preferences.setStringList(key, content);
    }


  }
}