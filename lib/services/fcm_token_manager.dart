// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:padelgo/utils/secure_storage_util.dart';
// import 'package:padelgo/repository/interfaces/authentication_repository.dart';

// class FCMTokenManager {
//   static const String _fcmTokenKey = 'fcm_token';
//   static const String _fcmTokenTimestampKey = 'fcm_token_timestamp';
//   static const int _maxRetries = 3;
//   static const Duration _retryDelay = Duration(seconds: 2);
//   static const Duration _debounceDelay = Duration(milliseconds: 500);

//   Timer? _debounceTimer;
//   String? _lastUploadedToken;
//   bool _isUploading = false;

//   final AuthenticationRepository _authRepository;

//   FCMTokenManager({
//     required AuthenticationRepository authRepository,
//   }) : _authRepository = authRepository;

//   Future<void> initialize() async {
//     try {
//       if (kDebugMode) {
//         print('🔔 FCM Token Manager: Initializing...');
//       }

//       final token = await _getAndPersistToken();

//       if (token != null && token.isNotEmpty) {
//         if (kDebugMode) {
//           print(
//               '🔔 FCM Token Manager: Token retrieved: ${token.substring(0, 20)}...');
//         }
//       } else {
//         if (kDebugMode) {
//           print('⚠️ FCM Token Manager: No token available');
//         }
//       }

//       _setupTokenRefreshListener();

//       if (kDebugMode) {
//         print('✅ FCM Token Manager: Initialization complete');
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('❌ FCM Token Manager: Initialization error: $e');
//       }
//     }
//   }

//   /// Upload stored token to backend
//   Future<void> uploadToken() async {
//     try {
//       final token = await getStoredToken();

//       if (token != null && token.isNotEmpty) {
//         if (kDebugMode) {
//           print('📤 FCM Token Manager: Uploading stored token');
//         }
//         await _uploadTokenIfAuthenticated(token);
//       } else {
//         // Try to get fresh token if no stored token
//         if (kDebugMode) {
//           print('🔄 FCM Token Manager: No stored token, fetching fresh token');
//         }
//         final freshToken = await _getAndPersistToken();
//         if (freshToken != null) {
//           await _uploadTokenIfAuthenticated(freshToken);
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('❌ FCM Token Manager: Upload token error: $e');
//       }
//     }
//   }

//   Future<String?> _getAndPersistToken() async {
//     try {
//       final token = await FirebaseMessaging.instance.getToken();

//       if (token != null && token.isNotEmpty) {
//         await _saveTokenLocally(token);
//         return token;
//       }

//       return null;
//     } catch (e) {
//       if (kDebugMode) {
//         print('❌ FCM Token Manager: Error getting token: $e');
//       }
//       return null;
//     }
//   }

//   Future<void> _saveTokenLocally(String token) async {
//     try {
//       await SecureStorageUtil.saveString(_fcmTokenKey, token);
//       await SecureStorageUtil.saveString(
//         _fcmTokenTimestampKey,
//         DateTime.now().millisecondsSinceEpoch.toString(),
//       );

//       if (kDebugMode) {
//         print('💾 FCM Token Manager: Token saved locally');
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('❌ FCM Token Manager: Error saving token locally: $e');
//       }
//     }
//   }

//   Future<String?> getStoredToken() async {
//     try {
//       return await SecureStorageUtil.getString(_fcmTokenKey);
//     } catch (e) {
//       if (kDebugMode) {
//         print('❌ FCM Token Manager: Error reading stored token: $e');
//       }
//       return null;
//     }
//   }

//   Future<void> _uploadTokenIfAuthenticated(String token) async {
//     await _uploadTokenWithRetry(token);
//   }

//   Future<void> _uploadTokenWithRetry(String token, {int attempt = 1}) async {
//     if (_isUploading) {
//       if (kDebugMode) {
//         print('⏭️ FCM Token Manager: Upload already in progress');
//       }
//       return;
//     }

//     if (_lastUploadedToken == token) {
//       if (kDebugMode) {
//         print('⏭️ FCM Token Manager: Token unchanged, skipping upload');
//       }
//       return;
//     }

//     _isUploading = true;

//     try {
//       if (kDebugMode) {
//         print(
//             '📤 FCM Token Manager: Uploading token (attempt $attempt/$_maxRetries)');
//       }

//       final success = await _authRepository.uploadFCMToken(token);

//       if (success) {
//         _lastUploadedToken = token;
//         if (kDebugMode) {
//           print('✅ FCM Token Manager: Token uploaded successfully');
//         }
//       } else {
//         throw Exception('Upload failed');
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('❌ FCM Token Manager: Upload error (attempt $attempt): $e');
//       }

//       if (attempt < _maxRetries) {
//         final delay = _retryDelay * attempt;
//         if (kDebugMode) {
//           print('🔄 FCM Token Manager: Retrying in ${delay.inSeconds}s...');
//         }

//         await Future.delayed(delay);
//         _isUploading = false;
//         await _uploadTokenWithRetry(token, attempt: attempt + 1);
//       } else {
//         if (kDebugMode) {
//           print('❌ FCM Token Manager: Max retries reached, giving up');
//         }
//       }
//     } finally {
//       _isUploading = false;
//     }
//   }

//   void _uploadTokenDebounced(String token) {
//     _debounceTimer?.cancel();
//     _debounceTimer = Timer(_debounceDelay, () {
//       _uploadTokenIfAuthenticated(token);
//     });
//   }

//   /// Set up listener for FCM token refresh
//   void _setupTokenRefreshListener() {
//     FirebaseMessaging.instance.onTokenRefresh.listen(
//       (newToken) {
//         if (kDebugMode) {
//           print('🔄 FCM Token Manager: Token refreshed');
//         }

//         // Save new token locally
//         _saveTokenLocally(newToken);

//         // Upload to backend with debounce
//         _uploadTokenDebounced(newToken);
//       },
//       onError: (error) {
//         if (kDebugMode) {
//           print('❌ FCM Token Manager: Token refresh error: $error');
//         }
//       },
//     );

//     if (kDebugMode) {
//       print('👂 FCM Token Manager: Token refresh listener active');
//     }
//   }

//   void dispose() {
//     _debounceTimer?.cancel();
//     if (kDebugMode) {
//       print('🧹 FCM Token Manager: Disposed');
//     }
//   }
// }
