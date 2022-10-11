

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_memory.dart';
import 'data_base.dart';

class BasketView extends StatefulWidget{
  final double width;
  final double height;
  const BasketView({super.key,required this.width,required this.height});

  @override
  State<StatefulWidget> createState()=>_BasketView();

}

class _BasketView extends State<BasketView>{
  bool _loading = true;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return  Container(height: widget.height,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(40)
      ),
      child: BlocBuilder<CounterBloc, int>(
        builder: (context, count) {
          return  _loading  ? Padding(padding: EdgeInsets.all(6),
            child: CircularProgressIndicator(color: Colors.white,strokeWidth: 1.8),
          ) : Padding(padding: EdgeInsets.only(left: 5,right: 5,bottom: 0),
          child: Text(count.toString(),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "Abzar",

              )
          ),
          );
        },
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    initCountBasket();
  }

  Future<void> initCountBasket() async {
     await DataUserBasket.countBasket().then((value){
  setState(() {
    _loading = false;
    context.read<CounterBloc>().add(CounterIncrementPressed());
  });
     });
  }

}