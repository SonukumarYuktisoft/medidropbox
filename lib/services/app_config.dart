class  AppConfig {
   String get baseUrl =>
      'https://backend-production-91e4.up.railway.app';
  // static const String token =
      // 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzdXBlckFkbWluQGdtYWlsLmNvbSIsImV4cCI6MTc1MzczMTExMiwiaWF0IjoxNzUzMTI2MzEyfQ.emjb_TARjXdjmACGb7rtvxHj3ce85ZdfI948WdLKajA';

   String get loginUrl => '$baseUrl/login/jwt';
   String get logout => '$baseUrl/logout';
 

  
}
