import 'package:source_span/source_span.dart';

class Token {
  final TokenType type;
  final FileSpan span;
  final Match match;

  Token(this.type, this.span, this.match);
}

enum TokenType {
  // Symbols
  arrow,
  comma,
  colon,
  doubleColon,
  lBracket,
  rBracket,
  lCurly,
  rCurly,
  lParen,
  rParen,
  semicolon,

  // Unary
  spread2,
  spread3,
  increment,
  decrement,
  not,
  tilde,

  // Arithmetic
  equals,
  exponent,
  times,
  divide,
  modulo,
  plus,
  minus,

  // Boolean
  booleanAnd,
  booleanOr,

  // Bitwise
  xor,
  and,
  or,
  shiftLeft,
  shiftRight,

  // Keywords
  as_,
  external,
  fn,
  import_,
  match,
  with_,

  // Data
  radix2,
  radix8,
  radix10,
  pow10,
  radix16,
  float_,
  string,
  id,
}
