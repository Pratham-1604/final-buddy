import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:chatapp/utils/MStyles.dart';

final voucher_data = [
  {
    "logo_url":
        "https://cdn.bleacherreport.net/images_root/slides/photos/000/914/008/air-jordan-17_display_image.jpg?1304480670",
    "discount": "10%",
    "issuer_name": "Brand 1",
    "expiry_date": "2023-12-31"
  },
  {
    "logo_url":
        "https://cdn.bleacherreport.net/images_root/slides/photos/000/914/008/air-jordan-17_display_image.jpg?1304480670",
    "discount": "15%",
    "issuer_name": "Brand 2",
    "expiry_date": "2023-09-30"
  },
  {
    "logo_url":
        "https://cdn.bleacherreport.net/images_root/slides/photos/000/914/008/air-jordan-17_display_image.jpg?1304480670",
    "discount": "20%",
    "issuer_name": "Brand 3",
    "expiry_date": "2024-06-30"
  },
  {
    "logo_url":
        "https://cdn.bleacherreport.net/images_root/slides/photos/000/914/008/air-jordan-17_display_image.jpg?1304480670",
    "discount": "25%",
    "issuer_name": "Brand 4",
    "expiry_date": "2023-11-15"
  },
  {
    "logo_url":
        "https://cdn.bleacherreport.net/images_root/slides/photos/000/914/008/air-jordan-17_display_image.jpg?1304480670",
    "discount": "30%",
    "issuer_name": "Brand 5",
    "expiry_date": "2024-03-31"
  },
  {
    "logo_url":
        "https://cdn.bleacherreport.net/images_root/slides/photos/000/914/008/air-jordan-17_display_image.jpg?1304480670",
    "discount": "40%",
    "issuer_name": "Brand 6",
    "expiry_date": "2024-12-31"
  },
  {
    "logo_url":
        "https://cdn.bleacherreport.net/images_root/slides/photos/000/914/008/air-jordan-17_display_image.jpg?1304480670",
    "discount": "50%",
    "issuer_name": "Brand 7",
    "expiry_date": "2023-10-31"
  },
  {
    "logo_url":
        "https://cdn.bleacherreport.net/images_root/slides/photos/000/914/008/air-jordan-17_display_image.jpg?1304480670",
    "discount": "5%",
    "issuer_name": "Brand 8",
    "expiry_date": "2023-08-31"
  }
];

String formatDate(String dateStr) {
  final inputDate = DateTime.parse(dateStr);
  final formattedDate = DateFormat('dd MMM yyyy').format(inputDate);
  return formattedDate;
}

class RewardsScreen extends StatefulWidget {

  static const routeName = '/rewards-screen';
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MStyles.pColor,
        titleSpacing: -10,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            }),
        title: Text(
          "Rewards",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          // Container(
          //   width: 100,
          //   height: 26,
          //   margin: const EdgeInsets.symmetric(vertical: 11),
          //   decoration: BoxDecoration(
          //     color: const Color(0xff1C2448),
          //     borderRadius: BorderRadius.circular(4),
          //   ),
          //   child: ElevatedButton(
          //     onPressed: () {},
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: const Color(0xff1C2448),
          //       // backgroundColor: MStyles.sColor,
          //       padding: const EdgeInsets.only(left: 10),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Text(
          //           "1849 ",
          //           style: GoogleFonts.poppins(
          //             textStyle: const TextStyle(
          //               color: Color(0xffB3B3B3),
          //               fontSize: 14,
          //               fontWeight: FontWeight.w500,
          //             ),
          //           ),
          //         ),
          //         // const Padding(
          //         //   padding: EdgeInsets.only(right: 5),
          //         // ),
          //         Container(
          //           width: 20,
          //           height: 20,
          //           decoration: const BoxDecoration(
          //             image: DecorationImage(
          //               image: AssetImage(
          //                 'assets/images/green_coins.png',
          //               ),
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          const SizedBox(
            width: 28,
          ),
          // InkWell(
          //   onTap: () {},
          //   child: const ImageIcon(
          //     size: 20,
          //     AssetImage('assets/images/green_coins.png'),
          //   ),
          // ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: RichText(
                    text: TextSpan(
                  text: "Your Green Coin balance is: 3523 ",
                  children: [
                    WidgetSpan(
                        child: Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/green_coins.png',
                          ),
                        ),
                      ),
                    ))
                  ],
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 32,
                    ),
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TabBar(
                        isScrollable: true,
                        controller: tabController,
                        // labelColor: const Color(0xff4764E3),
                        labelColor: MStyles.pColor,
                        labelStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        indicatorWeight: 2,
                        indicatorColor: MStyles.pColor,
                        unselectedLabelColor:
                            // const Color(0xffFFFFFF).withOpacity(0.5),
                            const Color(0x000).withOpacity(0.5),
                        tabs: const [
                          Tab(
                            text: 'Premium',
                          ),
                          Tab(
                            text: 'Classic',
                          ),
                          Tab(
                            text: 'Standard',
                          ),
                        ]),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: SizedBox(
                  height: 700, // width: 300,
                  child: TabBarView(controller: tabController, children: [
                    getRewardList(voucher_data
                        // .where(
                        //     (element) => element['category'] == 'premium')
                        // .toList(),
                        ),
                    getRewardList(voucher_data
                        // .where(
                        //     (element) => element['category'] == 'classic')
                        // .toList(),
                        ),
                    getRewardList(voucher_data
                        // .where(
                        //     (element) => element['category'] == 'standard')
                        // .toList(),
                        ),
                  ]),
                ),
              )
            ]),
      ),
    );
  }

  getRewardList(List data) {
    return Container(
      margin: const EdgeInsets.only(top: 0, bottom: 0),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox();
          },
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: ScreenUtil().screenWidth * 0.9,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: MStyles.pColor, // color: Colors.white54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.only(
                            top: 10, left: 15, bottom: 10, right: 5),
                        child: Transform.rotate(
                          angle: 1,
                          child: Image.network(
                            data[index]['logo_url'],
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[index]['issuer_name']),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Discount: " +
                              data[index]['discount'].toString() + "\n\nGreen Coins:    3523/1000"),
                        ],
                      )
                    ],
                  ),
                ),
                // Text(data[index]['issuer_name']),
              ],
            );
          }),
    );
  }
}
