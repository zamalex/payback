import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';

import '../model/auth_response.dart';
import '../model/product_model.dart';
import 'http/urls.dart';
import 'service_locator.dart';

class PreferenceUtils{

   SharedPreferences? sharedPreferences;


  initPrefs()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

 /* saveCart(String cart)async{
    if(sharedPreferences==null)
      await initPrefs();


    await sharedPreferences!.setString('cart',cart);
  }*/

   /*Future<String?> readCart()async{
     if(sharedPreferences==null)
       await initPrefs();

     String? s = sharedPreferences!.getString('cart');

     if(s==null)
       return null;


     return s;
   }*/
    Future<List<Product>> addToCart(Product product) async {
      List<Product> cart = await readCart();

      // Check if the product is already in the cart
      int existingIndex = cart.indexWhere((item) => item.id == product.id);

      if (existingIndex != -1) {
        // If the product exists, update its quantity
        cart[existingIndex].cartQuantity++;
      } else {
        // If the product doesn't exist, add it to the cart
        cart.add(product..cartQuantity=1);
      }
     await saveCart(cart);
    return cart;
   }

   // Remove a product from the cart
    Future<List<Product>> removeFromCart(Product product,{bool remove = false}) async {
      List<Product> cart = await readCart();

      // Check if the product is already in the cart
      int existingIndex = cart.indexWhere((item) => item.id == product.id);

      if (existingIndex != -1) {
        if(cart[existingIndex].cartQuantity<=1||remove){
          cart.removeAt(existingIndex);


        }
        else{
          cart[existingIndex].cartQuantity--;

        }
      }
      await saveCart(cart);
      return cart;
   }
    Future<List<Product>> readCart() async {
     if(sharedPreferences==null)
       await initPrefs();

     final String? cartJson = sharedPreferences?.getString('cart');

     if (cartJson != null) {
       final List<dynamic> cartList = jsonDecode(cartJson);
       final List<Product> products = cartList.map((item) => Product.fromJson(item)).toList();
       return products;
     } else {
       return [];
     }
   }

   // Save the cart to SharedPreferences
    Future<void> saveCart(List<Product> cart) async {
      if(sharedPreferences==null)
        await initPrefs();

      final List<Map<String, dynamic>> cartList = cart.map((product) => product.toJson()).toList();
     final String cartJson = jsonEncode(cartList);

     sharedPreferences?.setString('cart', cartJson);
   }

   Future<void> deleteAllCart() async {
      if(sharedPreferences==null)
        await initPrefs();

     sharedPreferences?.remove('cart');
   }

  saveUser(AuthResponse loginModel)async{
    if(sharedPreferences==null)
      await initPrefs();

    if(sl.isRegistered<AuthResponse>())
      sl.unregister<AuthResponse>();
    sl.registerSingleton(loginModel);

    Url.TOKEN = loginModel.data!.token!;

    await sharedPreferences!.setString('user',jsonEncode(loginModel.toJson()));
  }

  saveNotification()async{
    if(sharedPreferences==null)
      await initPrefs();



    await sharedPreferences!.setString('notification','You have new notification');
  }
   Future<String?> readNotification()async{
     if(sharedPreferences==null)
       await initPrefs();

     String? s = sharedPreferences!.getString('notification');

     if(s==null)
       return null;


     return s;
   }



   saveInvitation(String invitation)async{
    if(sharedPreferences==null)
      await initPrefs();



    await sharedPreferences!.setString('invitation',invitation);
  }
   Future<String?> readInvitation()async{
     if(sharedPreferences==null)
       await initPrefs();

     String? s = sharedPreferences!.getString('invitation');


     return s;
   }

   Future deleteInvitation()async{
     if(sharedPreferences==null)
       await initPrefs();

      sharedPreferences!.remove('invitation');

   }
  
  Future<AuthResponse?> readUser()async{
    if(sharedPreferences==null)
       await initPrefs();

    String? s = sharedPreferences!.getString('user');

    if(s==null)
      return null;


    return AuthResponse.fromJson(jsonDecode(s));
  }



  logout(){
    if(sl.isRegistered<AuthResponse>())
    sl.unregister<AuthResponse>();
    Url.TOKEN='';
    sharedPreferences!.remove('user');
    deleteAllCart();
  }


}