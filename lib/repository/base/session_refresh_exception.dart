class SessionRefreshedException implements Exception {
  final bool shouldRetry;
  SessionRefreshedException(this.shouldRetry);
  
  @override
  String toString() => 'Session has been refreshed. Retry: $shouldRetry';
}
