import '../model/product_model.dart';

class CheckoutObject{

   int selectedDelivery=0;
  int selectedPickup = 0;
  int vendor=0;

  List<Product> products=[];



  CheckoutObject({required this.vendor,required this.selectedDelivery,required this.selectedPickup,this.products=const[]});

}