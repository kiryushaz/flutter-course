import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/menu/bloc/menu_bloc.dart';
import 'package:flutter_course/src/features/menu/model/product.dart';
import 'package:flutter_course/src/theme/app_colors.dart';
import 'package:flutter_course/src/theme/image_sources.dart';

class Coffeecard extends StatefulWidget {
  final Product coffee;
  const Coffeecard({super.key, required this.coffee});

  @override
  _CoffeecardState createState() => _CoffeecardState();
}

class _CoffeecardState extends State<Coffeecard> {
  int _count = 0;

  Widget changeCountPurchasedItems(BuildContext context) {
    final MenuBloc bloc = context.read<MenuBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(32, 32),
                textStyle: Theme.of(context).textTheme.bodySmall,
                padding: const EdgeInsets.symmetric(vertical: 4.0)),
            onPressed: () {
              bloc.add(RemoveItemFromCartEvent(widget.coffee));
              setState(() => _count--);
            },
            child: const Text("-")),
        const SizedBox(width: 4),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(52, 32),
                textStyle: Theme.of(context).textTheme.bodySmall,
                padding: const EdgeInsets.symmetric(vertical: 4.0)),
            onPressed: () {
              log("${bloc.state.cartItems}");
            },
            child: Text("$_count")),
        const SizedBox(width: 4),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(32, 32),
                textStyle: Theme.of(context).textTheme.bodySmall,
                padding: const EdgeInsets.symmetric(vertical: 4.0)),
            onPressed: () {
              bloc.add(AddItemToCartEvent(widget.coffee));
              setState(() {
                if (_count < 10) {
                  _count++;
                }
              });
            },
            child: const Text("+")),
      ],
    );
  }

  Widget showPurchaseButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(116, 32),
            elevation: 0,
            textStyle: Theme.of(context).textTheme.bodySmall,
            padding: const EdgeInsets.symmetric(vertical: 4.0)),
        onPressed: () {
          context.read<MenuBloc>().add(AddItemToCartEvent(widget.coffee));
          setState(() => _count++);
        },
        child: Text(widget.coffee.prices[0].toString()));
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<MenuBloc>().state.cartItems!.isEmpty) {
      setState(() => _count = 0);
    }
    return Container(
      width: 180,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: ShapeDecoration(
          color: CoffeeAppColors.cardBackground,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      child: Column(children: [
        CachedNetworkImage(
          imageUrl: widget.coffee.imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            height: 100,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.contain)),
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => ImageSources.errorIcon,
        ),
        Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(widget.coffee.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium)),
        _count > 0
            ? changeCountPurchasedItems(context)
            : showPurchaseButton(context)
      ]),
    );
  }
}
