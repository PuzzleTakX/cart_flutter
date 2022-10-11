import 'dart:async';

import 'package:block_topmart/data_base.dart';
import 'package:block_topmart/model_cart.dart';
import 'package:block_topmart/model_datashop.dart';
import 'package:block_topmart/model_datauser.dart';
import 'package:block_topmart/shop_screen.dart';
import 'package:block_topmart/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_memory.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const App());
}

/// Custom [BlocObserver] that observes all bloc and cubit state changes.
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print("change ::::::: ${change.nextState} ::::  ${change.currentState}");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}

/// {@template app}
/// A [StatelessWidget] that:
/// * uses [bloc](https://pub.dev/packages/bloc) and
/// [flutter_bloc](https://pub.dev/packages/flutter_bloc)
/// to manage the state of a counter and the app theme.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: const AppView(),
    );
  }
}

/// {@template app_view}
/// A [StatelessWidget] that:
/// * reacts to state changes in the [ThemeCubit]
/// and updates the theme of the [MaterialApp].
/// * renders the [CounterPage].
/// {@endtemplate}
class AppView extends StatelessWidget {
  /// {@macro app_view}
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (_, theme) {
        return MaterialApp(
          theme: theme,
          home: const CounterPage(),
        );
      },
    );
  }
}

/// {@template counter_page}
/// A [StatelessWidget] that:
/// * provides a [CounterBloc] to the [CounterView].
/// {@endtemplate}
class CounterPage extends StatelessWidget {
  /// {@macro counter_page}
  const CounterPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(co: 0),
      child: const CounterView(),
    );
  }
}

/// {@template counter_view}
/// A [StatelessWidget] that:
/// * demonstrates how to consume and interact with a [CounterBloc].
/// {@endtemplate}
class CounterView extends StatelessWidget {
  /// {@macro counter_view}
  const CounterView({Key? key}) : super(key: key);








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  BlocBuilder<CounterBloc, int>(
        builder: (context, count) {
          return Text('$count',);
        },
      ),),
      body: Container(color: Colors.white,

        child: Column(
          children: [

            Container(width: double.maxFinite,height: 60,
            child: Center(
              child: BlocBuilder<CounterBloc, int>(
                builder: (context, count) {
                  return Text('$count',);
                },
              ),
            ),
            ),
            ElevatedButton(onPressed: () async {
             await Navigator.push(context, FadeRoute(page: ShopScreen())).then((value) =>    context.read<CounterBloc>().add(CounterIncrementPressed()));

            }, child: Text("navigat page")),


          ],
        ),

      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "btn2",
            child: const Icon(Icons.add),
            onPressed: () async {

              await DataUserBasket.addToCart(Cart(cnt: 1,image: "ssss",id: 547,title: "ddcddd",content: "ddddd")).then((value){
                context.read<CounterBloc>().add(CounterIncrementPressed());
              });
            },
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            heroTag: "btn1",
            child: const Icon(Icons.remove),
            onPressed: () {
              context.read<CounterBloc>().add(CounterDecrementPressed(cc: 5));
            },
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}


/// {@template brightness_cubit}
/// A simple [Cubit] that manages the [ThemeData] as its state.
/// {@endtemplate}
class ThemeCubit extends Cubit<ThemeData> {
  /// {@macro brightness_cubit}
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
    brightness: Brightness.light,
  );

  static final _darkTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
    ),
    brightness: Brightness.dark,
  );

  /// Toggles the current brightness between light and dark.
  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}