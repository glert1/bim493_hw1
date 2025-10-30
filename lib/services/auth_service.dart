import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Kullanıcı kaydı
  Future<bool> signUp(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Kullanıcı zaten var mı kontrol et
    String? existingUser = prefs.getString('user_$username');
    if (existingUser != null) {
      return false; // Kullanıcı zaten var
    }
    
    // Yeni kullanıcıyı kaydet
    await prefs.setString('user_$username', password);
    return true;
  }
  
  // Giriş yap
  Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    
    String? storedPassword = prefs.getString('user_$username');
    
    if (storedPassword != null && storedPassword == password) {
      // Başarılı giriş - kullanıcı oturumunu kaydet
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('currentUser', username);
      return true;
    }
    
    return false;
  }
  
  // Çıkış yap
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('currentUser');
  }
  
  // Kullanıcı giriş yapmış mı kontrol et
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
  
  // Mevcut kullanıcı adını al
  Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentUser');
  }
}