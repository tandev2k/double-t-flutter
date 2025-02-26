import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sp_shop_app/controllers/cart_controller.dart';
import 'package:sp_shop_app/entities/cart_item.dart';

class CartItemCard extends StatelessWidget {
  CartItemCard({Key? key, required this.available, required this.item})
      : super(key: key);

  CartItem item;
  bool available;
  final CartController _cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: () {
          if (available) {
            _cartController.pickToggle(item);
          }
        },
        child: Obx(
          () => Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10.0),
              child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 3.0,
                  child: Container(
                      padding: EdgeInsets.only(left: 15.0, right: 10.0),
                      width: MediaQuery.of(context).size.width - 20.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: 18.0,
                                  width: 18.0,
                                  decoration: BoxDecoration(
                                    color: available
                                        ? Colors.grey.withOpacity(0.4)
                                        : Colors.red.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(12.5),
                                  ),
                                  child: Center(
                                      child: available
                                          ? Container(
                                              height: 10.0,
                                              width: 10.0,
                                              decoration: BoxDecoration(
                                                  color: _cartController.isCartItemPicked(item)
                                                      ? Colors.yellow
                                                      : Colors.grey
                                                          .withOpacity(0.4),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0)),
                                            )
                                          : Container()))
                            ],
                          ),
                          SizedBox(width: 5.0),
                          Container(
                            height: size.width / 5,
                            width: size.width / 5,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        item.product?.productPictures[0]),
                                    fit: BoxFit.contain)),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width:
                                        size.width - 200 ,
                                    child: Text(item.product!.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(width: 7.0)
                                ],
                              ),
                              SizedBox(height: 7.0),
                              available
                                  ? Text(
                                      'Size: ' + item.size!.name,
                                      style: TextStyle(
                                          fontFamily: 'Quicksand',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                          color: Colors.grey),
                                    )
                                  : OutlineButton(
                                      onPressed: () {},
                                      borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                      child: Center(
                                        child: Text('Find Similar',
                                            style: TextStyle(
                                                fontFamily: 'Quicksand',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0,
                                                color: Colors.red)),
                                      ),
                                    ),
                              SizedBox(height: 7.0),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    available
                                        ? Text(
                                             item.product!.price.toString() + 'đ',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                                color: Color.fromARGB(
                                                    255, 255, 97, 24)),
                                          )
                                        : Container(),
                                    SizedBox(width: 20.0),
                                    Row(children: [
                                      Container(
                                          alignment: Alignment.centerRight,
                                          child: InkResponse(
                                            onTap: () {
                                              Object cartItem = {
                                                "product":
                                                    item.product!.id.toString(),
                                                "size":
                                                    item.size!.id.toString(),
                                                "quantity": item.quantity - 1
                                              };
                                               _cartController.changeQuantityProductInCart(cartItem);
                                            },
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10.0),
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.red,
                                              ),
                                            ),
                                          )),
                                      Text(
                                        '${item.quantity}',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 18.0,
                                            color: Colors.black),
                                      ),
                                      Container(
                                          alignment: Alignment.centerRight,
                                          child: InkResponse(
                                            onTap: () {
                                               Object cartItem = {
                                                "product":
                                                    item.product!.id.toString(),
                                                "size":
                                                    item.size!.id.toString(),
                                                "quantity": item.quantity + 1
                                              };
                                               _cartController.changeQuantityProductInCart(cartItem);
                                            },
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.0),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.red,
                                              ),
                                            ),
                                          )),
                                      Container(
                                          alignment: Alignment.centerRight,
                                          child: InkResponse(
                                            onTap: () {
                                              Object cartItem = {
                                                "product":
                                                    item.product!.id.toString(),
                                                "size":
                                                    item.size!.id.toString()
                                              };
                                               _cartController.removeCartItem(cartItem);
                                            },
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.0),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ))
                                    ])
                                  ]),
                            ],
                          )
                        ],
                      )))),
        ));
  }
}
