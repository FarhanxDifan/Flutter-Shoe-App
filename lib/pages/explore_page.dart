import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shoe_app/component/gnav_bar.dart';
import 'package:shoe_app/const/asset_const.dart';
import 'package:shoe_app/const/const_color.dart';
import 'package:shoe_app/const/ui_helper.dart';

import '../data/shoe_model.dart';
import '../util/hex_color.dart';

class ExplorePage extends StatefulHookConsumerWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> with SingleTickerProviderStateMixin {
  PageController productPageController = PageController();
  late AnimationController animationController;

  double currentProdPage = 0.0;

  @override
  void initState() {
    productPageController.addListener(pageListener);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

  pageListener() {
    setState(() {
      currentProdPage = productPageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: nikeAppBar(size),
      bottomNavigationBar: const GNavBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Explore Collection Text
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Explore\nCollection',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),

          // Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: PageView.builder(
                controller: productPageController,
                physics: const ScrollPhysics(),
                itemCount: Shoe.productList.length,
                itemBuilder: (context, index) {
                  final value = (currentProdPage - index).abs();
                  final scale = 1 - value.clamp(0, 0.2).toDouble();
                  final opacity = 1 - value.clamp(0, 1);

                  Shoe item = Shoe.productList[index];
                  return Stack(
                    children: [
                      // bg container
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColor.cardGrey,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 32,
                        right: 4,
                        child: Transform.rotate(
                          angle: -35 * math.pi / 180,
                          child: Container(
                            clipBehavior: Clip.none,
                            child: AnimatedBuilder(
                                animation: animationController,
                                builder: (context, snapshot) {
                                  final valueAnimation = Curves.linear.transform(animationController.value);

                                  return Opacity(
                                    opacity: opacity.toDouble(),
                                    child: Image.asset(
                                      item.img,
                                      height: 297.88 + 20,
                                      width: 297.88 + 20,
                                    )
                                        .animate()
                                        .scaleXY(
                                          end: scale,
                                        )
                                        .rotate(
                                          begin: 0 * valueAnimation,
                                          end: -0.09 * valueAnimation,
                                        ),
                                  );
                                }),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 32,
                          left: 32,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: Image.asset(
                                    AppAssets.starIcon,
                                    height: 16.35,
                                    width: 17.12,
                                  ),
                                ),
                                kHorizontalSpaceS,
                                const Text(
                                  'Highly Rated',
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: -0.6),
                                ),
                              ],
                            ),
                          )),
                      Positioned(
                        bottom: 32,
                        left: 32,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1.6,
                              ),
                            ),
                            kVerticalSpaceS,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                5,
                                (index) => Image.asset(
                                  AppAssets.starIcon,
                                  height: 16.35,
                                  width: 17.12,
                                ),
                              ),
                            ),
                            kVerticalSpaceS,
                            Text(
                              '\$${item.price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1.6,
                              ),
                            ),
                            kVerticalSpaceS,
                            // Variant
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Colors.black, width: 1)),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Image.asset(
                                        item.img,
                                        height: 33,
                                        width: 48,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ],
                                  ),
                                ),
                                kHorizontalSpaceS,
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Colors.white, width: 1)),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Image.asset(
                                        item.img,
                                        height: 33,
                                        width: 48,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: Container(
                          height: 74,
                          width: 74,
                          decoration: BoxDecoration(
                            color: HexColor(item.prodPrimaryColor),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(16),
                              topLeft: Radius.circular(16),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 42,
                            color: AppColor.cardGrey,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize nikeAppBar(Size size) {
    return PreferredSize(
      preferredSize: Size(size.width, kToolbarHeight),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 20),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Image.asset(
            AppAssets.nikeLogo,
            width: 47,
            height: 17,
          ),
          actions: [
            Image.asset(
              AppAssets.searchIcon,
              width: 18,
              height: 18,
              // fit: BoxFit.contain,
            ),
            const SizedBox(
              width: 16,
            ),
            Image.asset(
              AppAssets.cartIcon,
              width: 16,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
