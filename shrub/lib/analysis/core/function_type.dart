import '../package.dart';
import '../type.dart';

class ShrubFunctionType extends ShrubType {
  final List<ShrubType> parameters = [];
  ShrubType returnType;

  ShrubFunctionType(ShrubPackage package, String name) : super(package, name);

  @override
  String get qualifiedName {
    var paramString =
        '(' + parameters.map((t) => t.qualifiedName).join(', ') + ')';
    return paramString + ' => ' + returnType.qualifiedName;
  }

  @override
  bool isAssignableFrom(ShrubType other) {
    if (other is! ShrubFunctionType) return false;
    var fn = other as ShrubFunctionType;

    for (int i = 0; i < parameters.length; i++) {
      if (!parameters[i].isAssignableFrom(fn.parameters[i])) return false;
    }

    return returnType.isAssignableFrom(fn.returnType);
  }
}