import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_12/helpers/app_colors.dart';
import 'package:test_12/home/view/widgets/app_drawer.dart';
import 'package:test_12/home/view/widgets/cart_icon_badge.dart';
import 'package:test_12/home/view/widgets/category_tab.dart';
import 'package:test_12/home/view/widgets/dish_card.dart';
import '../../helpers/enums.dart';
import '../provider/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        surfaceTintColor: AppColors.bgWhite,
        actions: const [CartIconBadge()],
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        top: false,
        child: Consumer<HomeViewModel>(
          builder: (context, vm, _) {
            switch (vm.status) {

              case HomeStatusEnum.loading:
                return const Center(
                  child: CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(Colors.green),strokeWidth: 1,),
                );

              case HomeStatusEnum.noInternet:
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.wifi_off, size: 48),
                      const SizedBox(height: 10),
                      Text(vm.errorMessage ?? 'No internet connection'),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: vm.loadMenu,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );

              case HomeStatusEnum.apiError:
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 48),
                      const SizedBox(height: 10),
                      Text(vm.errorMessage ?? 'Something went wrong'),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: vm.loadMenu,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );

              case HomeStatusEnum.success:
                final categories = vm.menuModel?.categories ?? [];

                if (categories.isEmpty) {
                  return const Center(child: Text('No data available'));
                }

                final selectedCategory =
                categories[vm.selectedCategoryIndex];

                return Column(
                  children: [
                    CategoryTabs(categories: categories, vm: vm),
                    const Divider(height: 1),
                    Expanded(
                      child: ListView.builder(
                        itemCount: selectedCategory.dishes.length,
                        itemBuilder: (_, index) =>
                            DishTile(dish: selectedCategory.dishes[index]),
                      ),
                    ),
                  ],
                );

              case HomeStatusEnum.initial:
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}