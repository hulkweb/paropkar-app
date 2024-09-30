import 'package:paropkar/src/controller/cart/cart_controller.dart';

class ControllerIntance{
   static CartController cart(context){
      return context.read<CartController>();
    }
}