import 'package:json_annotation/json_annotation.dart';

part 'admin.g.dart';

@JsonSerializable()
class Admin {
  final int id;
  final String name;
  final String email;
  final String status;

  Admin(
      {required this.id,
      required this.name,
      required this.email,
      required this.status,
      });

  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);
  Map<String, dynamic> toJson() => _$AdminToJson(this);
}
