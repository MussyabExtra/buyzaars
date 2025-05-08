import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buyzaars/app/modules/my_orders/controllers/my_orders_controller.dart';
import '../../../../utilities/colors.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.red,
        foregroundColor: AppColor.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.red),
            ),
          );
        }

        return FocusScope(
          node: FocusScopeNode(),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.allorders.length,
                    itemBuilder: (context, index) {
                      final order = controller.allorders[index];
                      return Card(
                        color: AppColor.secondaryColor,
                        margin: EdgeInsets.only(bottom: 16),
                        elevation: 2,
                        child: Row(
                          children: [
                            // Order Details
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "ORDER: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.black),
                                        ),
                                        Expanded(
                                          child: SelectableText(
                                              controller
                                                  .allorders[index].orderKey
                                                  .toString(),
                                              style: TextStyle(
                                                  color: AppColor.black)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "DATE: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.black),
                                        ),
                                        Expanded(
                                          child: Text(
                                              order.dateCreated.toString(),
                                              style: TextStyle(
                                                  color: AppColor.black)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "STATUS: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.black),
                                        ),
                                        Expanded(
                                          child: Text(
                                              order.status.toString() ==
                                                      "wc-completed"
                                                  ? "Completed"
                                                  : "Pending",
                                              style: TextStyle(
                                                  color: AppColor.black)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "TOTAL: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.black),
                                        ),
                                        Expanded(
                                          child: Text(
                                              "\$${(double.parse(order.total!))}",
                                              style: TextStyle(
                                                  color: AppColor.black)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
              ],
            ),
          ),
        );
      }),
    );
  }
}
