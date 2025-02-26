import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sp_shop_app/components/bottom_navigation.dart';
import 'package:sp_shop_app/components/rounded_button.dart';
import 'package:sp_shop_app/controllers/behavior_controller.dart';
import 'package:sp_shop_app/controllers/cart_controller.dart';
import 'package:sp_shop_app/controllers/product_controller.dart';
import 'package:sp_shop_app/screens/ProductDetail/components/product_thumb.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, required this.slug}) : super(key: key);

  final String slug;
  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductController _productController = Get.put(ProductController());
  final CartController _cartController = Get.put(CartController());
  final BehaviorController _behaviorController = Get.put(BehaviorController());
  @override
  void initState() {
    super.initState();
    _productController.getProduct(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.file_upload_outlined),
              color: Colors.black,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Align(
              alignment: Alignment.center,
              child: Obx(() => ProductThumb(
                  product: _productController.productBySlug.value))),
        ),
        floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: RoundedButton(
              press: () {
                Object cartItem = {
                  "product":
                      _productController.productBySlug.value.id.toString(),
                  "size": _productController.sizeSelected.value,
                  "quantity": _cartController.getQuantityAfterVerified(
                      _productController.productBySlug.value.id.toString(),
                      _productController.sizeSelected.value,
                      _productController.quantitySelected)
                };
                _cartController.addToCart(cartItem);
                _behaviorController.addBehavior(
                    _productController.productBySlug.value.id, "addToCart");
              },
              text: "Thêm vào giỏ",
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigation());
  }
}
