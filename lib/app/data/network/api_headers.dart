import 'dart:developer';


class ApiHeaders {
  // Private constructor to prevent external instantiation
  ApiHeaders._();

  // Singleton instance
  static final ApiHeaders _instance = ApiHeaders._();
  static ApiHeaders get instance => _instance;

  // Storage for headers
  final Map<String, dynamic> _headers = {};

  // Authentication token
  String? _authToken;
  String? _refreshToken;

  // User/Device info
  String? _userId;
  String? _deviceId;
  String? _appVersion;

  /// Initialize headers with app-specific information
  void initialize({
    String? appVersion,
    String? deviceId,
    String? platform,
    String? deviceModel,
  }) {
    _appVersion = appVersion;
    _deviceId = deviceId;

    // Set basic headers that are always needed
    _headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': 'en-US,en;q=0.9',
      'Cache-Control': 'no-cache',
    });

    // Add device/app info if provided
    if (appVersion != null) {
      _headers['App-Version'] = appVersion;
    }

    if (deviceId != null) {
      _headers['Device-ID'] = deviceId;
    }

    if (platform != null) {
      _headers['Platform'] = platform;
    }

    if (deviceModel != null) {
      _headers['Device-Model'] = deviceModel;
    }

    // Add timestamp for request tracking
    _headers['Request-Time'] = DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Set authentication token
  void setAuthToken(String token) {
    _authToken = token;
    _headers['Authorization'] = 'Bearer $token';
  }

  /// Set refresh token
  void setRefreshToken(String token) {
    _refreshToken = token;
    _headers['X-Refresh-Token'] = token;
  }

  /// Set user ID
  void setUserId(String userId) {
    _userId = userId;
    _headers['X-User-ID'] = userId;
  }

  /// Set API key
  void setApiKey(String apiKey) {
    _headers['X-API-KEY'] = apiKey;
  }

  /// Set custom header
  void setCustomHeader(String key, String value) {
    _headers[key] = value;
  }

  /// Set multiple headers at once
  void setHeaders(Map<String, dynamic> headers) {
    _headers.addAll(headers);
  }

  /// Remove specific header
  void removeHeader(String key) {
    _headers.remove(key);

    // Clear related tokens if auth headers are removed
    if (key == 'Authorization') {
      _authToken = null;
    } else if (key == 'X-Refresh-Token') {
      _refreshToken = null;
    } else if (key == 'X-User-ID') {
      _userId = null;
    }
  }

  /// Clear all authentication related headers
  void clearAuth() {
    _authToken = null;
    _refreshToken = null;
    _userId = null;
    _headers.remove('Authorization');
    _headers.remove('X-Refresh-Token');
    _headers.remove('X-User-ID');
  }

  /// Clear all headers (except basic ones)
  void clearAll() {
    _authToken = null;
    _refreshToken = null;
    _userId = null;
    _headers.clear();

    // Re-initialize basic headers
    initialize(appVersion: _appVersion, deviceId: _deviceId);
  }

  /// Get all headers
  Map<String, dynamic> getAllHeaders() {
    // Update request time for each call
    _headers['Request-Time'] = DateTime.now().millisecondsSinceEpoch.toString();
    return Map<String, dynamic>.from(_headers);
  }

  /// Get headers with additional custom headers merged
  Map<String, dynamic> getHeadersWith(Map<String, dynamic>? additionalHeaders) {
    final allHeaders = getAllHeaders();

    if (additionalHeaders != null && additionalHeaders.isNotEmpty) {
      // Additional headers override default ones
      allHeaders.addAll(additionalHeaders);
    }

    return allHeaders;
  }

  /// Get headers for specific API types
  Map<String, dynamic> getAuthHeaders() {
    if (_authToken == null) {
      throw Exception('Authentication token not set. Please login first.');
    }
    return getAllHeaders();
  }

  Map<String, dynamic> getPublicHeaders() {
    final publicHeaders = Map<String, dynamic>.from(_headers);
    // Remove auth-related headers for public APIs
    publicHeaders.remove('Authorization');
    publicHeaders.remove('X-Refresh-Token');
    publicHeaders.remove('X-User-ID');
    return publicHeaders;
  }

  Map<String, dynamic> getUserHeaders() {
    final publicHeaders = Map<String, dynamic>.from(_headers);
   // setUserId(SessionController().user.data!.first.tblDealerId.toString());
    return publicHeaders;
  }

  Map<String, dynamic> getBasicHeaders() {
    final basicHeaders = Map<String, dynamic>.from(_headers);
    basicHeaders.remove('Content-Type'); // Remove Content-Type for file uploads
    basicHeaders['Request-Time'] = DateTime.now().millisecondsSinceEpoch
        .toString();
    return basicHeaders;
  }

  Map<String, dynamic> getUploadHeaders() {
    final uploadHeaders = getAllHeaders();
    // Remove this line - let Dio handle Content-Type automatically
    // uploadHeaders['Content-Type'] = 'multipart/form-data';

    // Or better yet, don't set Content-Type at all for uploads
    uploadHeaders.remove('Content-Type');
    return uploadHeaders;
  }

  /// Get specific header value
  String? getHeader(String key) {
    return _headers[key]?.toString();
  }

  /// Check if header exists
  bool hasHeader(String key) {
    return _headers.containsKey(key);
  }

  /// Check if user is authenticated
  bool get isAuthenticated => _authToken != null && _authToken!.isNotEmpty;

  /// Get current auth token
  String? get authToken => _authToken;

  /// Get current refresh token
  String? get refreshToken => _refreshToken;

  /// Get current user ID
  String? get userId => _userId;

  /// Print all headers for debugging
  void debugPrintHeaders() {
    _headers.forEach((key, value) {
      log('$key: $value', name: 'API HEADERS');
    });
    log('========================');
  }
}
