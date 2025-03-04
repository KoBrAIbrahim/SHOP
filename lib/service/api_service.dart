import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:mainapp/models/admin.dart'; 

part 'api_service.g.dart'; 

@RestApi(baseUrl: "https://gorest.co.in/public-api/users")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/users")
  Future<List<Admin>> getAdmins();
}
