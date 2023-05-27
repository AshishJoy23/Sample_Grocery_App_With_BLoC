import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grocery_app_bloc/data/cart_items.dart';
import 'package:grocery_app_bloc/features/home/model/product_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveEvent>(cartRemoveEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    await Future.delayed(
      const Duration(seconds: 1),
    );
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveEvent(
      CartRemoveEvent event, Emitter<CartState> emit) {
        cartItems.remove(event.removedProduct);
        emit(CartRemovedState());
        emit(CartSuccessState(cartItems: cartItems));
      }
}
