import 'package:flutter/material.dart';
import 'package:local_government_app/screens/AuthenticatedUser/serviceScreens/addproperty/addProperty.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';

class ViewAddedProperty extends StatefulWidget {
  const ViewAddedProperty({super.key});

  @override
  State<ViewAddedProperty> createState() => _ViewAddedPropertyState();
}

class _ViewAddedPropertyState extends State<ViewAddedProperty> {

void _openAddLeaveSheet() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddProperty(),
    );

    // If the sheet returns true, it means a leave was submitted.
    // Set the initial status.
    /*if (result == true) {
      setState(() {
        _currentLeaveStatus = LeaveStatus.submitted;
      });
    }*/
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            size: size.width * 0.05,
            color: ColorPack.black,
          ),
        ),
        title: Text(
          "Add Property",
          style: tTextStyleBold.copyWith(
            color: ColorPack.black,
            fontSize: size.width * 0.045,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: size.height*0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/add_property.png",
                    width: size.width * 0.20,
                    height: size.width * 0.20,
                  ),
                ),
                GestureDetector(
                // Set onTap to null when disabled
                onTap: _openAddLeaveSheet,
                behavior: HitTestBehavior.translucent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.015),
                      child: Center(
                        child: Container(
                          width: size.width * 0.20,
                          height: size.height * 0.04,
                          decoration: BoxDecoration(
                            color: ColorPack.grayBorder,
                            //border: Border.all(color: ColorPack.red),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              "Add Property",
                              style: tTextStyle700.copyWith(
                                color: ColorPack.black,
                                fontSize: size.width * 0.025,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
