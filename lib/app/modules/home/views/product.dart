// import 'package:buyzaars/utilities/colors.dart';
// import 'package:buyzaars/widgets/product_card.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Product extends StatelessWidget {
//   Product({super.key});

//   final List<Map<String, dynamic>> products = [
//     {
//       "name": "The Great Gatsby",
//       "author": "F. Scott Fitzgerald",
//       "price": "10.99",
//       "image": "assets/images/Book-1.png",
//       "tags": ["Design", "User Interfare"]
//     },
//     {
//       "name": "Becoming",
//       "author": "Michelle Obama",
//       "price": "19.99",
//       "image": "assets/images/Book-3.png",
//       "tags": ["Design", "User Interfare"]
//     },
//     {
//       "name": "Atomic Habits",
//       "author": "James Clear",
//       "price": "15.99",
//       "image": "assets/images/Book-2.png",
//       "tags": ["Design", "User Interfare"]
//     },
//     {
//       "name": "Sapiens: A Brief History of Humankind",
//       "author": "Yuval Noah Harari",
//       "price": "18.50",
//       "image": "assets/images/Book-1.png",
//       "tags": ["Design", "User Interfare"]
//     },
//     {
//       "name": "Educated",
//       "author": "Tara Westover",
//       "price": "14.99",
//       "image": "assets/images/Book-3.png",
//       "tags": ["Design", "User Interfare"]
//     },
//     {
//       "name": "The Power of Now",
//       "author": "Eckhart Tolle",
//       "price": "12.99",
//       "image": "assets/images/Book-2.png",
//       "tags": ["Design", "User Interfare"]
//     },
//     {
//       "name": "The Catcher in the Rye",
//       "author": "J.D. Salinger",
//       "price": "9.99",
//       "image": "assets/images/Book-1.png",
//       "tags": ["Design", "User Interfare"]
//     },
//     {
//       "name": "1984",
//       "author": "George Orwell",
//       "price": "13.99",
//       "image": "assets/images/Book-3.png",
//       "tags": ["Design", "User Interfare"]
//     },
//     {
//       "name": "The Alchemist",
//       "author": "Paulo Coelho",
//       "price": "11.99",
//       "image": "assets/images/Book-1.png",
//       "tags": ["Design", "User Interfare"]
//     },
//     {
//       "name": "To Kill a Mockingbird",
//       "author": "Harper Lee",
//       "price": "12.50",
//       "image": "assets/images/Book-2.png",
//       "tags": ["Design", "User Interfare"]
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.primarycolor,
//       body: Container(
//         width: Get.width,
//         child: ListView.builder(
//           padding: EdgeInsets.only(top: 20),
//           shrinkWrap: true,
//           itemCount: products.length,
//           physics: const NeverScrollableScrollPhysics(),
//           // scrollDirection: Axis.vertical,
//           itemBuilder: (context, index) => Padding(
//             padding: const EdgeInsets.only(bottom: 20),
//             child: GestureDetector(
//               onTap: () => Get.toNamed("/single-product"),
//               child: SizedBox(
//                 height: 120,
//                 child: productCard(
//                   name: products[index]["name"]!,
//                   author: products[index]["author"]!,
//                   price: products[index]["price"]!,
//                   image: products[index]["image"]!,
//                   tags: List<String>.from(products[index]["tags"]),
//                   context: context,
//                   index: index,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
