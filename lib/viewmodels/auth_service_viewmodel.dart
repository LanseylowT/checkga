import 'package:checkga/models/app_user.dart';
import 'package:checkga/repositories/auth_service_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServiceViewmodel extends ChangeNotifier {
  final AuthServiceRepository _authRepository;
  final UserRole _userRole = UserRole.guest;
  final String _userCacheKey = "user_role";
  final String _userCacheUIDKey = "cached_uid";

  UserRole get userRole => _userRole;

  AuthServiceViewmodel(this._authRepository);

  Future<UserRole> getUserRole() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? uid = prefs.getString(_userCacheUIDKey);

      if (uid == null) {
        uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid != null) {
          _cacheUser(uid);
        } else {
          // Handle the case where currentUser is null
        }
      }

      // Try getting the role from cache first
      final cachedRole = prefs.getString(_userCacheKey);
      if (cachedRole != null) {
        return _stringToUserRole(cachedRole);
      }

      // Fetch role from Firestore
      final role = await _authRepository.fetchUserRole(uid!);

      // Cache the role for offline use
      prefs.setString(_userCacheKey, _userRoleToString(role));

      return role;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userCacheKey);
    await prefs.remove(_userCacheUIDKey);
  }

  UserRole _stringToUserRole(String role) {
    switch (role) {
      case 'admin':
        return UserRole.admin;
      case 'staff':
        return UserRole.staff;
      default:
        return UserRole.guest;
    }
  }

  String _userRoleToString(UserRole role) {
    return role.toString().split('.').last;
  }

  // Handles the Signing In and Out of the shit
  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await _authRepository.signInWithEmail(email, password);
      await _cacheUser(userCredential.user!.uid);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _cacheUser(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userCacheUIDKey, uid);
  }
}
