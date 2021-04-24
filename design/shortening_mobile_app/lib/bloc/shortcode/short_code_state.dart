part of 'short_code_cubit.dart';

@immutable
abstract class ShortCodeState {
  const ShortCodeState();
}

class ShortCodeInitial extends ShortCodeState {}

class ShortCodeError extends ShortCodeState {
  final String error;
  const ShortCodeError(this.error);
}

class ShortCodeLoading extends ShortCodeState {}

class ShortCodeUrlDone extends ShortCodeState {
  final ShortCodeLink link;
  const ShortCodeUrlDone(this.link);
}
