import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grocery_app_bloc/data/cart_items.dart';
import 'package:grocery_app_bloc/data/grocery_data.dart';
import 'package:grocery_app_bloc/data/wishlist_items.dart';
import 'package:grocery_app_bloc/features/home/model/product_data_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeWishlistNavigateEvent>(homeWishlistNavigateEvent);
    on<HomeCartNavigateEvent>(homeCartNavigateEvent);
    on<HomeProductWishlistClickedEvent>(homeProductWishlistClickedEvent);
    on<HomeProductCartClickedEvent>(homeProductCartClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(
      const Duration(seconds: 3),
    );
    emit(
      HomeLoadedSuccessState(
        products: GroceryData.groceryProducts.map(
          (e) => ProductDataModel(
            id: e['id'],
            name: e['name'],
            category: e['category'],
            price: e['price'],
            imageUrl: e['imageUrl'],
          ),
        ).toList(),
      ),
    );
  }

  FutureOr<void> homeWishlistNavigateEvent(
      HomeWishlistNavigateEvent event, Emitter<HomeState> emit) {
    print('Navigate to wishlist');
    emit(HomeWishlistNavigationActionState());
  }

  FutureOr<void> homeCartNavigateEvent(
      HomeCartNavigateEvent event, Emitter<HomeState> emit) {
    print('Navigate to cart');
    emit(HomeCartNavigationActionState());
  }

  FutureOr<void> homeProductWishlistClickedEvent(
      HomeProductWishlistClickedEvent event, Emitter<HomeState> emit) {
        print('wishlist clicked');
        if (wishlistItems.contains(event.clickedProduct)) {
          emit(HomeAlreadyAddedActionState());
        } else {
          wishlistItems.add(event.clickedProduct);
          emit(HomeWishlistAddedActionState());
        }
        
      }

  FutureOr<void> homeProductCartClickedEvent(
      HomeProductCartClickedEvent event, Emitter<HomeState> emit) {
        print('cart clicked');
        if (cartItems.contains(event.clickedProduct)) {
          emit(HomeAlreadyAddedActionState());
        } else {
          cartItems.add(event.clickedProduct);
          emit(HomeCartAddedActionState());
        }
        
      }
}
