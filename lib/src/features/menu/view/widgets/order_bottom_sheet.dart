import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/theme/image_sources.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_course/src/features/menu/bloc/menu_bloc.dart';
import 'package:flutter_course/src/features/menu/model/product.dart';

class OrderBottomSheet extends StatefulWidget {
  const OrderBottomSheet({super.key});

  @override
  _OrderBottomSheetState createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.bottomSheetTitle,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 24)),
                    IconButton(
                        onPressed: () {
                          context.read<MenuBloc>().add(const ClearCartEvent());
                          Navigator.of(context).pop();
                        },
                        icon: ImageSources.deleteIcon)
                  ]),
            ),
            const Divider(),
            const SizedBox(height: 10),
            ListView.separated(
              controller: ScrollController(),
              shrinkWrap: true,
              itemCount: context.read<MenuBloc>().state.cartItems!.length,
              itemBuilder: (context, index) {
                return ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    leading: CachedNetworkImage(
                      imageUrl: context
                          .read<MenuBloc>()
                          .state
                          .cartItems![index]
                          .imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.contain)),
                      ),
                      errorWidget: (context, url, error) =>
                          ImageSources.errorIcon,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                          context.read<MenuBloc>().state.cartItems![index].name,
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                          context
                              .read<MenuBloc>()
                              .state
                              .cartItems![index]
                              .description,
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    trailing: Text(
                        context
                            .read<MenuBloc>()
                            .state
                            .cartItems![index]
                            .prices[0]
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)));
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  onPressed: () {
                    final orderJson =
                        createOrder(context.read<MenuBloc>().state.cartItems!);
                    log('$orderJson');
                    context
                        .read<MenuBloc>()
                        .add(CreateNewOrderEvent(orderJson));
                    Navigator.of(context).pop();
                    context.read<MenuBloc>().add(const ClearCartEvent());
                  },
                  child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                            child: Text(
                                AppLocalizations.of(context)!.bottomSheetButton,
                                style: Theme.of(context).textTheme.bodyLarge)),
                      ))),
            )
          ],
        ),
      ),
    );
  }

  Map<String, int> createOrder(List<Product> cart) {
    Map<String, int> orderJson = {};

    for (var element in cart) {
      final product = element.id.toString();
      if (!orderJson.containsKey(product)) {
        orderJson[product] = 1;
      } else {
        orderJson.update(product, (value) => value + 1);
      }
    }

    return orderJson;
  }
}
