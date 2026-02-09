import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/ui_helper.dart';
import '../provider/home_view_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        surfaceTintColor: AppColors.bgWhite,
        title: Text('Order Summary',
          style:  TextStyle(
          fontSize: 16,
          color: AppColors.subGrey,
          fontWeight: FontWeight.w500,
        ),
        ),
        leading: BackButton(color: AppColors.subGrey),
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, vm, _) {
          final cartItems = vm.items.entries.toList();

          if (cartItems.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          final totalAmount = cartItems.fold<double>(
            0,
                (sum, entry) {
              final dish = vm.getDishById(entry.key);
              if (dish == null) return sum;
              return sum + (double.parse(dish.price) * entry.value);
            },
          );

          return Column(
            children: [

              Expanded(
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade900,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            '${cartItems.length} Dishes - ${vm.totalCount} Items',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),

                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(12),
                          itemCount: cartItems.length,
                          separatorBuilder: (_, _) => const Divider(
                            height: 24,
                            thickness: 0.8,
                          ),
                          itemBuilder: (context, index) {
                            final entry = cartItems[index];
                            final dish = vm.getDishById(entry.key)!;
                            final qty = entry.value;
                            final isVeg = dish.isVeg;
                            final totalPrice =
                            (double.parse(dish.price) * qty).toStringAsFixed(2);

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 14,
                                  height: 14,
                                  margin: const EdgeInsets.only(top: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isVeg ? Colors.green : Colors.red,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: isVeg ? Colors.green : Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                horizontalSpaceTiny,
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dish.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      verticalSpaceTiny,
                                      Text('INR ${dish.price}',
                                        style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),),
                                      verticalSpaceTiny,
                                      Text(
                                        '${dish.calories} calories',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  flex: 4,
                                  child: Center(
                                    child: Container(
                                      height: 34,
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade900,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () => vm.decrement(dish.id),
                                            child: const Icon(Icons.remove,
                                                color: Colors.white, size: 14),
                                          ),
                                          horizontalSpaceSmall,
                                          Text(
                                            qty.toString(),
                                            style: const TextStyle(
                                                fontSize: 12, color: Colors.white),
                                          ),
                                          horizontalSpaceSmall,
                                          InkWell(
                                            onTap: () => vm.increment(dish.id),
                                            child: const Icon(Icons.add,
                                                color: Colors.white, size: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'INR $totalPrice',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'INR ${totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      vm.items.clear();
                      Themes.showSuccessSnackBar(msg: 'Order Placed Successfully, Thank You',);
                      Navigator.pop(context);
                      vm.refresh();
                    },
                    child: const Text(
                      'Place Order',
                      style: TextStyle(fontSize: 16, color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

}
