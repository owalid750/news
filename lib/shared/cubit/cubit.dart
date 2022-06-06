import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';

import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());

  bool isDark = false;
  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: "isDark", value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  static AppCubit get(context) => BlocProvider.of(context);
}
