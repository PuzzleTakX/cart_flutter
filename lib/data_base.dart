
import 'package:block_topmart/model_cart.dart';
import 'package:block_topmart/model_datashop.dart';
import 'dart:convert' show jsonDecode, jsonEncode, utf8;
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as enc;
import 'dart:async';
 import 'package:php_serializer/php_serializer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model_datauser.dart';
class DataUserBasket{

static Future<SharedPreferences> _dataBaseInitialize() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("CartUser") == false){
      List<Cart> l = [];
      Map<String,dynamic> m= {"CartProduct":l};
      prefs.setString("CartUser", jsonEncode(m));
    }
   if(prefs.containsKey("basket_id") == false) prefs.setInt("basket_id",0);
    if(prefs.containsKey("shop_id") == false) prefs.setInt("shop_id",0);

    return prefs;
  }




  // clear all basket
static deleteAllBasket() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("CartUser");
}

// add item in list basket product
static Future<void> addToCart(Cart cart) async{
  final dataBase = await _dataBaseInitialize();
  Map<String,dynamic> myBasket = jsonDecode(dataBase.getString("CartUser")!);

  int shopID = dataBase.getInt("shop_id")!;
  int basketID = dataBase.getInt("basket_id")!;

  //list data
  List<dynamic> cartList = myBasket["CartProduct"];
  List<Cart> newCart = [];
  for (var element in cartList) { newCart.add(Cart.fromJson(element)); }

  cart.shopId = shopID;
  cart.basketId = basketID;
  bool hasItem = false;
  newCart.forEach((element) {
    if(hasItem == false){
      hasItem = (element.id == cart.id && element.basketId == cart.basketId && element.shopId == cart.shopId);
    }
  });




   if(hasItem){

   }else{


     newCart.add(cart);
     myBasket["CartProduct"] = newCart;
     dataBase.setString("CartUser", jsonEncode(myBasket));
   }

}

  static Future<int> getCntProduct({required int productId}) async {
    final dataBase = await _dataBaseInitialize();
    Map<String,dynamic> myBasket = jsonDecode(dataBase.getString("CartUser")!);

    int shopID = dataBase.getInt("shop_id")!;
    int basketID = dataBase.getInt("basket_id")!;

    List<dynamic> cartList = myBasket["CartProduct"];
    List<Cart> newCart = [];
    for (var element in cartList) { newCart.add(Cart.fromJson(element)); }

    bool hasItem = false;
    int cnt = 0;
    for (var element in newCart) {
      if(hasItem == false){
        if((element.id == productId && element.basketId == basketID && element.shopId == shopID)) cnt = element.cnt!;
        hasItem = (element.id == productId && element.basketId == basketID && element.shopId == shopID);
      }
    }
    return cnt;
  }

  // get count add  single product
  static Future<void> removeCntProduct({required int productId}) async {
    final dataBase = await _dataBaseInitialize();
    Map<String,dynamic> myBasket = jsonDecode(dataBase.getString("CartUser")!);

    int shopID = dataBase.getInt("shop_id")!;
    int basketID = dataBase.getInt("basket_id")!;

    List<dynamic> cartList = myBasket["CartProduct"];
    List<Cart> newCart = [];
    for (var element in cartList) { newCart.add(Cart.fromJson(element)); }

    bool hasItem = false;
    int index = -1;
    Cart mCart = Cart();

    for (var element in newCart) {
      if(hasItem == false){
        if((element.id == productId && element.basketId == basketID && element.shopId == shopID)){
          index = newCart.indexOf(element);
          mCart  =element;
        }
        hasItem = (element.id == productId && element.basketId == basketID && element.shopId == shopID);
      }
    }

    if(index != -1){
      mCart.cnt = (mCart.cnt! - 1);
      newCart[index] = mCart;
      myBasket["CartProduct"] = newCart;
      dataBase.setString("CartUser", jsonEncode(myBasket));
    }

  }


// get count add  single product
static Future<void> addCntProduct({required int productId}) async {
  final dataBase = await _dataBaseInitialize();
  Map<String,dynamic> myBasket = jsonDecode(dataBase.getString("CartUser")!);

  int shopID = dataBase.getInt("shop_id")!;
  int basketID = dataBase.getInt("basket_id")!;

  List<dynamic> cartList = myBasket["CartProduct"];
  List<Cart> newCart = [];
  for (var element in cartList) { newCart.add(Cart.fromJson(element)); }

  bool hasItem = false;
  int index = -1;
  Cart mCart = Cart();

  for (var element in newCart) {
    if(hasItem == false){
      if((element.id == productId && element.basketId == basketID && element.shopId == shopID)){
       index = newCart.indexOf(element);
       mCart  =element;
      }
      hasItem = (element.id == productId && element.basketId == basketID && element.shopId == shopID);
    }
  }

 if(index != -1){
   mCart.cnt = (mCart.cnt! + 1);
   newCart[index] = mCart;
   myBasket["CartProduct"] = newCart;
   dataBase.setString("CartUser", jsonEncode(myBasket));
 }

}

// check is  added item in dataBase (is Added == true)
static Future<bool> getContainsProduct({required int productId}) async {
  final dataBase = await _dataBaseInitialize();
  Map<String,dynamic> myBasket = jsonDecode(dataBase.getString("CartUser")!);

  int shopID = dataBase.getInt("shop_id")!;
  int basketID = dataBase.getInt("basket_id")!;

  List<dynamic> cartList = myBasket["CartProduct"];
  List<Cart> newCart = [];
  for (var element in cartList) { newCart.add(Cart.fromJson(element)); }
  bool hasItem = false;
  for (var element in newCart) {
    if(hasItem == false){
      hasItem = (element.id == productId && element.basketId == basketID && element.shopId == shopID);
    }
  }
  return hasItem;
}

// get count all item database
static Future<int> countBasket() async {
    final dataBase = await _dataBaseInitialize();
    Map<String,dynamic> myBasket = jsonDecode(dataBase.getString("CartUser")!);

    int shopID =  0;
    int basketID = dataBase.getInt("basket_id")!;
    List<dynamic> cartList = myBasket["CartProduct"];

    List<Cart> newCart = [];
    int counter = 0;
    for (var element in cartList) { newCart.add(Cart.fromJson(element)); }

    for (var element in newCart) {
      if(element.basketId == basketID && element.shopId == shopID){
        counter += 1;
      }
    }
     return counter;
  }

// delete a item in list basket
static deleteItemProductAlt({required int productId}) async {
  final dataBase = await _dataBaseInitialize();
  Map<String,dynamic> myBasket = jsonDecode(dataBase.getString("CartUser")!);

  int shopID = dataBase.getInt("shop_id")!;
  int basketID = dataBase.getInt("basket_id")!;

  List<dynamic> cartList = myBasket["CartProduct"];
  List<Cart> newCart = [];
  for (var element in cartList) { newCart.add(Cart.fromJson(element)); }
  int index = -1;
  for (var element in newCart) {
    if(element.id == productId && element.basketId == basketID && element.shopId == shopID){
      // newCart.removeAt();
      index = newCart.indexOf(element);
    }
  }
  if(index != -1) newCart.removeAt(index);
  myBasket["CartProduct"] = newCart;
  dataBase.setString("CartUser", jsonEncode(myBasket));
}

// get basket ans send server
static Future<String> basketToJson() async {
  final dataBase = await _dataBaseInitialize();
  Map<String,dynamic> myBasket = jsonDecode(dataBase.getString("CartUser")!);

  int shopID = dataBase.getInt("shop_id")!;
  int basketID = dataBase.getInt("basket_id")!;

  List<dynamic> cartList = myBasket["CartProduct"];
  List<Map<String,dynamic>> newCart = [];
  for (var element in cartList) {
     if(element["shop_id"] == shopID) newCart.add({"cnt":element["cnt"],"id":element["id"]});
  }
  return jsonEncode(newCart);
}


}

class DataUser{

  /// _dataBaseInitialize for user
  static Future<SharedPreferences> _dataBaseInitialize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }
 /// set data user
  static setDataUser(DataUserModel dataUserModel) async {
    final dataBase = await _dataBaseInitialize();
    dataBase.setString("user_data",jsonEncode(dataUserModel.toJson()));
  }
  /// get data user
  static Future<DataUserModel> getDataUser() async {
    final dataBase = await _dataBaseInitialize();
    return DataUserModel.fromJson(jsonDecode(dataBase.getString("user_data")!));
  }

}

class DataShop{
  /// _dataBaseInitialize for details basket
  static Future<SharedPreferences> _dataBaseInitialize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }
  /// set basket id 
  static setBasketId(int basket) async {
    final dataBase = await _dataBaseInitialize();
    dataBase.setInt("shop_id", basket);
  }
  /// get basket id 
  static Future<int> getBasketId() async{
    final dataBase = await _dataBaseInitialize();
    return dataBase.getInt("shop_id")!;
  }
}

class DataBasket{
  /// _dataBaseInitialize for details basket
  static Future<SharedPreferences> _dataBaseInitialize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }
  /// set basket id 
  static setBasketId(int basket) async {
    final dataBase = await _dataBaseInitialize();
    dataBase.setInt("basket_id", basket);
  }
  /// get basket id 
  static Future<int> getBasketId() async{
    final dataBase = await _dataBaseInitialize();
    return dataBase.getInt("basket_id")!;
  }


}


