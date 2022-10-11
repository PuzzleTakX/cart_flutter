
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert' as Key;

import 'basket_view.dart';
import 'bloc_memory.dart';
import 'button_pay.dart';
import 'data_base.dart';
import 'model_cart.dart';

class ShopScreen extends StatefulWidget{
  const ShopScreen({super.key});

  @override
  State<StatefulWidget> createState()=>  _ShopScreen();
}

class _ShopScreen extends State<ShopScreen>{
  final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  int coutBasekt  = 0;
  final key = "my32lengthsupersecretnooneknows1";
  final iv = IV.fromSecureRandom(16);
  // final key = Key.fromUtf8('my32lengthsupersecretnooneknows1');

  // final encrypted = encrypter.encrypt(plainText, iv: iv);
  // final decrypted = encrypter.decrypt(encrypted, iv: iv);
  //
  // print(decrypted);
  // print(encrypted.bytes);
  // print(encrypted.base16);
  // print(encrypted.base64);
  String testTes = 'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.';
  List<int> li = [];
 final List<Cart> _list = [
   Cart(
       title: "title",
       image: "https://www.gardendesign.com/pictures/images/263x300Exact_62x0/site_3/helianthus-yellow-flower-pixabay_11863.jpg",
       id: 1,
       content: "content",
       // counter: 1
   ),
   Cart(
       title: "title",
       image: "https://www.gardendesign.com/pictures/images/263x300Exact_62x0/site_3/helianthus-yellow-flower-pixabay_11863.jpg",
       id: 1,
       content: "content",
       // counter: 1
   ),
   Cart(
       title: "title",
       image: "https://www.gardendesign.com/pictures/images/263x300Exact_62x0/site_3/helianthus-yellow-flower-pixabay_11863.jpg",
       id: 1,
       content: "content",
       // counter: 1
   ),
  ];

 @override
  void initState() {
    super.initState();

    //
  }
  void updateBasekt(){
    final xx =DataUserBasket.countBasket();
    setState(() {
      coutBasekt = xx as int;
    });
  }
 
 Widget block({required Widget child}){

   return BlocProvider(
     lazy: true,
     create: (_) => CounterBloc(co: coutBasekt),
     child: child,
   );
 }

  Widget _listSmator(){
    return Container(width: double.maxFinite,height: 180,
      color: Colors.transparent,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            return Container(height: double.maxFinite,width: 150,color: Colors.transparent,
              padding: EdgeInsets.all(2),
              child: Container(
                width: double.maxFinite,height: double.maxFinite,color: Colors.blueGrey.withAlpha(40),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Center(child: Text("index ::$index"),),
                    Expanded(child: Container()),
                    Container(width: double.maxFinite,height: 40,
                    child: ButtonPay(index: index,height: 40,),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),);
          })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return block(
      child: SafeArea(child: Scaffold(
        body: Container(color: Colors.white,
          child: Column(
            children: [
              Container(width: double.maxFinite,height: 55,
              child: Center(
                child: BlocBuilder<CounterBloc, int>(
                  builder: (context, count) {
                    return Text('$count',);
                  },
                ),
              ),
              ),
              _listSmator(),
              Container(width: double.maxFinite,height: 80,

                child: Center(
                  child: BasketView(height: 20,width: 20,),
                ),

              )

            ],
          ),
        ),
      )),
    );
  }

}