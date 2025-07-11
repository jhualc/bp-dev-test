function fn() {
  var config = {};
  config.baseUrl = java.lang.System.getenv('BASE_URL') || 'http://localhost:8080';
  return config;
}
