import 'package:flutter/material.dart';
import 'package:local_government_app/screens/AuthenticatedUser/serviceScreens/makePayments/makePaymentScreen.dart';
import 'package:local_government_app/screens/AuthenticatedUser/widget/govCard.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';

class GovernmentService extends StatefulWidget {
  const GovernmentService({super.key});

  @override
  State<GovernmentService> createState() => _GovernmentServiceState();
}

class _GovernmentServiceState extends State<GovernmentService> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: ColorPack.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: ColorPack.black.withOpacity(0.5),
            size: size.width * 0.08,
          ),
        ),
        title: Text(
          "Government Services",
          style: tTextStyleBold.copyWith(
            color: ColorPack.black,
            fontSize: size.width * 0.045,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height*0.02, left: size.width*0.02, right: size.width*0.02),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomGovServiceCard(
                      title: "Make Payment",
                      image: "assets/images/make_payment.png",
                      color: ColorPack.discoverBlue.withOpacity(0.15),
                      description: "Pay taxes,fees & municipal charges",
                      buttonTitle: "Make Payment",
                      buttonColor: ColorPack.discoverBlue.withOpacity(0.7),
                      buttonIcon: Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                        color: ColorPack.white,
                      ), onTap: () {   Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MakePayment()),
                );},
                    ),
                    SizedBox(width: size.width*0.02,),
                     CustomGovServiceCard(
                      title: "Request Services",
                      image: "assets/images/request_services.png",
                      color: ColorPack.red.withOpacity(0.3),
                      description: "Business permits,waste pickup & more",
                      buttonTitle: "Request Services",
                      buttonColor: ColorPack.iconGrey.withOpacity(0.9),
                      buttonIcon: Icon(
                        Icons.add,
                        size: 10,
                        color: ColorPack.white,
                      ), onTap: () {  },
                    ),
                  ],
                ),
              ),
               Padding(
                padding: EdgeInsets.only(top: size.height*0.01, left: size.width*0.02, right: size.width*0.02),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomGovServiceCard(
                      title: "Report Incidents",
                      image: "assets/images/incident_img.png",
                      color: ColorPack.discoverBlue.withOpacity(0.15),
                      description: "Infrastructure Issues & emergencies",
                      buttonTitle: "Make a report",
                      buttonColor: ColorPack.darkGreen.withOpacity(0.7),
                      buttonIcon: Icon(
                        Icons.save,
                        size: 10,
                        color: ColorPack.white,
                      ), onTap: () {  },
                    ),
                    SizedBox(width: size.width*0.02,),
                     CustomGovServiceCard(
                      title: "Manage Account",
                      image: "assets/images/manage-accounts.png",
                      color: ColorPack.iconBeige,
                      description: "Profile,settings & preferences",
                      buttonTitle: "Manage my account",
                      buttonColor: ColorPack.darkGray.withOpacity(0.9),
                      buttonIcon: Icon(
                        Icons.list,
                        size: 10,
                        color: ColorPack.white,
                      ), onTap: () {  },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height*0.01, left: size.width*0.02, right: size.width*0.02, bottom: size.height*0.03),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomGovServiceCard(
                      title: "Inbox & Notifications",
                      image: "assets/images/inbox_img.png",
                      color: ColorPack.discoverBlue.withOpacity(0.15),
                      description: "Messages from assemblies & updates",
                      buttonTitle: "Open",
                      buttonColor: ColorPack.discoverYellow.withOpacity(0.7),
                      buttonIcon: Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                        color: ColorPack.white,
                      ), onTap: () {  },
                    ),
                    SizedBox(width: size.width*0.02,),
                     CustomGovServiceCard(
                      title: "Service Tracker",
                      image: "assets/images/tracker_img.png",
                      color: ColorPack.iconBeige,
                      description: "Track your requests & applications",
                      buttonTitle: "Track Service",
                      buttonColor: ColorPack.red.withOpacity(0.9),
                      buttonIcon: Icon(
                        Icons.bar_chart,
                        size: 10,
                        color: ColorPack.white,
                      ), onTap: () {  },
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
