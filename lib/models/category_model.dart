import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class Category extends Equatable {
  final String id;
  final String name;
  final String type; // 'income' or 'expense'
  final String? icon;
  final String? color;
  final bool isDefault;
  
  const Category({
    required this.id,
    required this.name,
    required this.type,
    this.icon,
    this.color,
    this.isDefault = false,
  });
  
  factory Category.fromJson(Map<String, dynamic> json) => 
      _$CategoryFromJson(json);
  
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
  
  Category copyWith({
    String? id,
    String? name,
    String? type,
    String? icon,
    String? color,
    bool? isDefault,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      isDefault: isDefault ?? this.isDefault,
    );
  }
  
  @override
  List<Object?> get props => [id, name, type, icon, color, isDefault];
}
