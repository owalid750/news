import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'bloc_observer.dart';
import 'layout/home_screan.dart';
import 'layout/news_cubit/cubit.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? isDark = CacheHelper.getData(key: "isDark");
  await CacheHelper.init();

  BlocOverrides.runZoned(
    () {
      DioHelper.init();

      runApp(MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubitt()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
            create: (context) => AppCubit()..changeMode(fromShared: isDark))
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                primarySwatch: Colors.deepOrange,
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Color.fromARGB(255, 155, 110, 96)),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.grey,
                        statusBarBrightness: Brightness.dark),
                    backgroundColor: Colors.white,
                    elevation: 0)),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData(
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                scaffoldBackgroundColor: HexColor('333739'),
                primarySwatch: Colors.deepOrange,
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: HexColor('333739'),
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.grey),
                appBarTheme: AppBarTheme(
                    iconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    titleTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor('333739'),
                        statusBarBrightness: Brightness.light),
                    backgroundColor: HexColor('333739'),
                    elevation: 0)),
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
