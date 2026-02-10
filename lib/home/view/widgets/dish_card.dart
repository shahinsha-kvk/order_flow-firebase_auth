import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_12/helpers/app_colors.dart';
import '../../../helpers/ui_helper.dart';
import '../../model/menu_model.dart';
import '../../provider/home_view_model.dart';
import 'veg_non_veg_indicator.dart';

class DishTile extends StatelessWidget {
  final Dish dish;

  const DishTile({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, vm, _) {
        final qty = vm.getQty(dish.id);

        return Card(
          color: AppColors.bgWhite,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: VegNonVegIndicator(isVeg: dish.isVeg),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dish.name, style:  TextStyle(fontSize: getWidth(context: context)*0.04, fontWeight: FontWeight.w500),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('₹ ${dish.price}',style: TextStyle(fontSize: getWidth(context: context)*0.035,)),
                          Text('${dish.calories} calories',style: TextStyle(fontSize: getWidth(context: context)*0.035,)),
                        ],
                      ),

                      SizedBox(height: getHeight(context: context) * 0.01),

                      Text(
                        dish.description,
                        style: TextStyle(fontSize: getWidth(context: context)*0.03, color: Colors.grey.shade600),
                      ),

                      SizedBox(height: getHeight(context: context) * 0.01),

                      Container(
                        width: getWidth(context: context) * 0.32,
                        height: getWidth(context: context) * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon:  Icon(Icons.remove, color: Colors.white, size: getWidth(context: context)*0.04),
                              onPressed: () =>
                                  vm.decrement(dish.id),
                            ),
                            Text(
                              qty.toString(),
                              style:  TextStyle(fontSize: getWidth(context: context)*0.04, color: Colors.white),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon:  Icon(Icons.add, color: Colors.white, size: getWidth(context: context)*0.04),
                              onPressed: () =>
                                  vm.increment(dish.id),
                            ),
                          ],
                        ),
                      ),

                      if (dish.customizationsAvailable)
                         Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Text(
                            'Customizations Available',
                            style: TextStyle(color: Colors.red, fontSize: getWidth(context: context)*0.04),
                          ),
                        ),
                    ],
                  ),
                ),

                // IMAGE
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: dish.imageUrl,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      placeholder: (_, _) =>
                      const SizedBox(
                        width: 70,
                        height: 70,
                        child: Center(
                          child: CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(Colors.green),strokeWidth: 1,)
                        ),
                      ),
                      errorWidget: (_, _, _) =>
                      const Icon(Icons.fastfood),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
