import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buyzaars/app/modules/my_orders/controllers/my_orders_controller.dart';
import '../../../../utilities/colors.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
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
                      return GestureDetector(
                        onTap: () {
                           showModalBottomSheet(
                            context: context,
                            backgroundColor: AppColor.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                            ),
                            builder: (_) {
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          width: 40,
                                          height: 4,
                                          margin: EdgeInsets.only(bottom: 16),
                                          decoration: BoxDecoration(
                                            color: AppColor.secondaryColor,
                                            borderRadius: BorderRadius.circular(2),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Order #${order.id}',
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Date: ${order.dateCreated.toString().split("T")[0]}',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Status: ${order.status == "wc-completed" ? "Completed" : order.status}',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Total: \$${order.total}',
                                        style: TextStyle(color: AppColor.black, fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      SizedBox(height: 16),
                                      Divider(color: AppColor.black),
                                      Text(
                                        'Items Ordered (${order.lineItems!.length}):',
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      ...order.lineItems!.map<Widget>((item) => Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.name!,
                                                    style: TextStyle(
                                                      color: AppColor.black,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    'Qty: ${item.quantity}',
                                                    style: TextStyle(color: Colors.black, fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              '\$${item.total}',
                                              style: TextStyle(color: AppColor.black, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      )),
                                      Divider(color: AppColor.black),
                                      SizedBox(height: 10),
                                      Text(
                                        'Order Details',
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Payment: ${order.paymentMethodTitle}',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Shipping: ${order.shipping!.address1}, ${order.shipping!.city}, ${order.shipping!.state}, ${order.shipping!.country}',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Payment Status: ${order.datePaid?.isNotEmpty ?? false ? "Paid" : "Not Paid"}',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Payment Date: ${order.datePaid?.isNotEmpty ?? false ? order.datePaid : "Not Paid"}',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(height: 12),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          onPressed: () => Navigator.pop(context),
                                          child: Text('Close', style: TextStyle(color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Card(
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
                                                    .allorders[index].id
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
