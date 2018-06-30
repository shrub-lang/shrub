import 'package:shrub/shrub.dart';
import 'package:source_span/source_span.dart';

abstract class TypeContext {
  FileSpan get span;

  ShrubType resolved;
}

class IdentifierTypeContext extends TypeContext {
  final IdentifierContext identifier;

  IdentifierTypeContext(this.identifier);

  @override
  FileSpan get span => identifier.span;
}
