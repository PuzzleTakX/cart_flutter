
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_memory.dart';
import 'data_base.dart';
import 'model_cart.dart';

class ButtonPay extends StatefulWidget{
  final int index;
  final double height;
  ButtonPay({super.key, required this.index,required this.height});
  @override
  State<StatefulWidget> createState()=>_ButtonPay();

}

class _ButtonPay extends State<ButtonPay>{
  late int count = 0;

  @override
  void initState() {
    super.initState();
    chekCount();
  }


  Future<void> chekCount() async {
    await DataUserBasket.getCntProduct(productId: widget.index).then((value){
      setState(() {
       count = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(width: double.maxFinite,height: double.maxFinite,color: Colors.transparent,
      padding: EdgeInsets.only(left: 4,right: 4),
      child:  (count <= 0) ? _buttonAdd()  : _buttonAddMore() ,
    );
  }


  Widget _buttonAdd(){
    return Padding(
      padding: EdgeInsets.only(left: 1,right: 1,top: 2.0,bottom: 2.5),
      child: ElevatedButton(onPressed: (){  addToCart();},
        style: TextButton.styleFrom(
          elevation: 0.0,
          backgroundColor: Color(0xFFF07427),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
        ), child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("افزودن به سبد خرید",
              maxLines: 1,
              style: TextStyle(
                  fontFamily: "Abzar",
                  fontWeight: FontWeight.bold,
                  fontSize: 11
              ),
            ),
            Expanded(child: Container()),
            Icon(
              Icons.shopping_cart_checkout_sharp,
              size: 15,
            )
          ],),


      ),
    );
  }
  Widget _buttonAddMore(){
    return Row(
      children: [
        Container(width:  widget.height,height: widget.height,
            child: Padding(
                padding: EdgeInsets.all(6),
                child: InkWell(
                  onTap: onMinesClick,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Icon(
                        (count <= 1) ? Icons.delete_forever : Icons.remove,
                        size:(count <= 1) ?  18 : 21,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
            )
        ),
        Expanded(child: Container(
          padding: EdgeInsets.only(top: 4,bottom: 4),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(250),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey.withAlpha(140))
            ),
            child: Center(
              child: Row(
                children: [
                  SizedBox(width: 9,),
                  Expanded(child: Center(child: Text("$count",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontFamily: "Abzar",

                    ),
                  ),)),
                  Icon(Icons.keyboard_arrow_down,size: 15,color: Colors.grey,),
                  SizedBox(width: 2,),
                ],
              )
            ),
          ),
        )),
        Container(width:  widget.height,height: widget.height,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: InkWell(
                onTap: onAddPlusClick,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 21,
                        color: Colors.white,
                    ),
                  ),
                ),
              )
            )
        ),

      ],
    );
  }

  Future<void> removeToCart() async {
    await DataUserBasket.getContainsProduct(productId: widget.index).then((hasProduct) async {
      if (hasProduct) {
        await DataUserBasket.getCntProduct(productId: widget.index).then((cnt) async {

          if (cnt <= 1){
            await DataUserBasket.deleteItemProductAlt(productId: widget.index).then((value){
              context.read<CounterBloc>().add(CounterIncrementPressed());
              chekCount();
            });
          }else{
            await DataUserBasket.removeCntProduct(productId: widget.index).then((value){
              context.read<CounterBloc>().add(CounterIncrementPressed());
              chekCount();
            });
          }


        });

      }
    });

  }

  Future<void> addToCart() async {
    await DataUserBasket.getContainsProduct(productId: widget.index).then((hasProduct) async {
      if (hasProduct) {
        await DataUserBasket.addCntProduct(productId: widget.index).then((value){
          context.read<CounterBloc>().add(CounterIncrementPressed());
          chekCount();
        });
      }else{
        await DataUserBasket.addToCart(Cart(cnt: 1,image: "ssss",id: widget.index,title: "ddcddd",content: "ddddd")).then((value){
          context.read<CounterBloc>().add(CounterIncrementPressed());
          chekCount();
        });
      }
    });

  }

/// onclick add plus
onAddPlusClick(){
  addToCart();
}

/// onclick Mines
onMinesClick(){
  removeToCart();
}

onStartAddClick(){
  addToCart();
}

}
