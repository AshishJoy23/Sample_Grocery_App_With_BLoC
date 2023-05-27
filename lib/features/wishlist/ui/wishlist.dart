import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app_bloc/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:grocery_app_bloc/features/wishlist/ui/wishlist_tile_widget.dart';
import 'package:lottie/lottie.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wishlist Items',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listener: (context, state) {
          if (state is WishlistRemovedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 500),
                backgroundColor: Colors.green,
                content: Text('Item removed from cart!'),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistLoadingState:
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.teal,
                ),
              );
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;
              return successState.wishlistItems.isEmpty
                  ? Center(
                      child: Lottie.asset('assets/animations/no_data1.json'),
                    )
                  : ListView.builder(
                      itemCount: successState.wishlistItems.length,
                      itemBuilder: (context, index) {
                        return WishlistTileWidget(
                          productDataModel: successState.wishlistItems[index],
                          wishlistBloc: wishlistBloc,
                        );
                      },
                    );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
