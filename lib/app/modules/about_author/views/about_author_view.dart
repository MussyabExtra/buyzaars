import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/colors.dart';
import '../controllers/about_author_controller.dart';

class AboutAuthorView extends GetView<AboutAuthorController> {
  AboutAuthorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Author',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColor.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.red,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back, color: AppColor.white)),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColor.WhitebackgroundGradient,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Buyzaars Store',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'For many years I have written poems, stories and journals to put my thoughts and feelings down on paper. I thank the Lord for this day, for helping me on my way. When I was growing up my Grandma wrote in a little book and kept all the important information right with her so she could remember myriads of writings. She left me her little book with poems to spice up my life and I have been intrigued with writing ever since.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'When I was in College, I read a poem in the Centenary College Literary Contest and became interested in poetry and reciting poetry and giving speeches. Everyone goes through trials and tribulations, hard times and harder times but with faith in God, getting through , making it and coming out ahead of the game is what is important.. I have had experiences that some people thought were horrible. When I was a small child we travelled extensively and I was away from home and school for three months at a time. I was an only child and I had fun with my Mother and Father every day in our car or a motel room. I had the measles on one trip and they had to blacken the windows. Another time we were snowed in and had to have our car lifted out of the hotel parking lot by a crane as my Dad had an important assignment. That was a thrill.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
