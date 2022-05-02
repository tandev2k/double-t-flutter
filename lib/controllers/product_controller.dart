import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sp_shop_app/apis/product_api.dart';
import 'package:sp_shop_app/entities/product.dart';
import 'package:sp_shop_app/utils/constants.dart';

class ProductController extends GetxController {
  var hotProducts = [].obs;
  var featuredProducts = [].obs;

  getProducts() async {
    try {
      EasyLoading.show(status: Constants.WAIT);
      hotProducts.value = await ProductApi.getProducts();
      featuredProducts.value = hotProducts.value.reversed.toList();
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      Get.defaultDialog(
        title: Constants.WARNING_TITLE,
        titleStyle:
            TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor),
        middleText: "Đã có lỗi xảy ra",
        textCancel: Constants.I_KNOW,
      );
    } finally {
      EasyLoading.dismiss();
    }
  }
}
