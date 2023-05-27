import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grocery_app_bloc/data/wishlist_items.dart';
import 'package:grocery_app_bloc/features/home/model/product_data_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveEvent>(wishlistRemoveEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingState());
    await Future.delayed(
      const Duration(seconds: 1),
    );
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> wishlistRemoveEvent(
      WishlistRemoveEvent event, Emitter<WishlistState> emit) {
        wishlistItems.remove(event.removedProduct);
        emit(WishlistRemovedState());
        emit(WishlistSuccessState(wishlistItems: wishlistItems));
      }
}

