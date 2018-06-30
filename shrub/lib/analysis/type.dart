import 'package:shrub/shrub.dart';

class ShrubType {
  final Module package;
  final String name;

  // final TypeContext declaration;

  ShrubType(this.package, this.name);

  String get qualifiedName => '${package.qualifiedName}::$name';

  bool isExactly(ShrubType other) => other.qualifiedName == qualifiedName;

  bool isAssignableFrom(ShrubType other) => isExactly(other);
}
