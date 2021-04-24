import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shortening_mobile_app/data/model/short_code_link.dart';
import 'package:shortening_mobile_app/data/model/shorten_result.dart';
import 'package:shortening_mobile_app/data/service/short_code_service.dart';

part 'short_code_state.dart';

class ShortCodeCubit extends Cubit<ShortCodeState> {
  final ShortCodeService service;
  ShortCodeCubit(this.service) : super(ShortCodeInitial());
  void shortALink(String url) async {
    emit(ShortCodeLoading());
    ShortCodeResult result = await service.shortLink(url);
    if (result.isOk) {
      emit(ShortCodeUrlDone(ShortCodeLink.fromJson(result.result)));
    } else {
      emit(ShortCodeError(result.error));
    }
  }
}
