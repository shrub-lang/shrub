import 'package:shrub/shrub.dart';

class SimpleIdentifierParser implements PrefixParselet {
  const SimpleIdentifierParser();

  @override
  ExpressionContext parse(Parser parser, Token token) =>
      new SimpleIdentifierContext(token.span);
}

class IntegerLiteralParser implements PrefixParselet<int> {
  const IntegerLiteralParser();

  @override
  ExpressionContext<int> parse(Parser parser, Token token) {
    return new IntegerLiteralContext(token);
  }
}