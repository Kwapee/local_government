import 'package:flutter/material.dart';
import 'package:local_government_app/screens/AuthenticatedUser/serviceScreens/makePayments/widgets/makePaymentCards.dart';
import 'package:local_government_app/utils/app_theme.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';
import 'package:local_government_app/widgets/expandlistwidget.dart';
import 'package:local_government_app/widgets/scrollbar.dart';

class MakePayment extends StatefulWidget {
  const MakePayment({super.key});

  @override
  State<MakePayment> createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  final List<String> _serviceList = [
    "Waste Management",
    "Property Rate Tax",
    "Rent(Assembly Property)",
    "Business Permit",
    "Bill & Signpost Permit",
  ];

  String? _selectedServiceType;
  bool isServiceTypeExpanded = false;

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
          "Make Payment",
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
              // Your info cards...
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.03,
                  right: size.width * 0.02,
                  left: size.width * 0.02,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomMakePaymentCard(
                      title: "Total Paid",
                      subtitle: "GHC 200",
                      icon: "assets/images/payment.png",
                      numDescription: "This Year",
                      avatarColor: ColorPack.discoverBlue,
                      containerColor: ColorPack.white,
                    ),
                    SizedBox(width: size.width * 0.02),
                    CustomMakePaymentCard(
                      title: "Total Due",
                      subtitle: "GHC 850",
                      icon: "assets/images/pending-actions.png",
                      numDescription: "This Month",
                      avatarColor: ColorPack.red,
                      containerColor: ColorPack.white,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.02,
                  right: size.width * 0.02,
                  left: size.width * 0.02,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomMakePaymentCard(
                      title: "Success Payments",
                      subtitle: "8",
                      icon: "assets/images/success_img.png",
                      numDescription: "",
                      avatarColor: ColorPack.green,
                      containerColor: ColorPack.white,
                    ),
                    SizedBox(width: size.width * 0.02),
                    CustomMakePaymentCard(
                      title: "Outstanding Dues",
                      subtitle: "3",
                      icon: "assets/images/logout.png",
                      numDescription: "",
                      avatarColor: ColorPack.discoverYellow,
                      containerColor: ColorPack.white,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.03,
                  left: size.width * 0.02,
                  right: size.width * 0.02,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorPack.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        blurRadius: 5.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Make a Payment",
                          style: tTextStyleBold.copyWith(
                            color: ColorPack.black,
                            fontSize: size.width * 0.05,
                          ),
                        ),
                        SizedBox(height: size.height * 0.015),
                        Text(
                          "Select Service Type",
                          style: tTextStyle500.copyWith(
                            color: ColorPack.black,
                            fontSize: size.width * 0.035,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        _buildDropdown(
                          hintText: 'Select Service Type',
                          selectedValue: _selectedServiceType,
                          items: _serviceList,
                          isExpanded: isServiceTypeExpanded,
                          onToggle: (isExpanded) {
                            setState(() {
                              isServiceTypeExpanded = isExpanded;
                            });
                          },
                          // This callback now handles setting the value AND closing the list
                          onSelect: (newValue) {
                            setState(() {
                              _selectedServiceType = newValue;
                              isServiceTypeExpanded = false; // Close the dropdown on selection
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- REFACTORED AND CORRECTED DROPDOWN WIDGET ---
  Widget _buildDropdown({
    required String hintText,
    required String? selectedValue,
    required List<String> items,
    required bool isExpanded,
    required ValueChanged<bool> onToggle,
    required ValueChanged<String?> onSelect,
  }) {
    return Column(
      children: [
        // This is the main dropdown box that is always visible
        GestureDetector(
          onTap: () {
            onToggle(!isExpanded);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.white,
              border: Border.all(color: ColorPack.darkGray),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedValue ?? hintText,
                  style: tTextStyleRegular.copyWith(
                    fontSize: 16,
                    color:
                        selectedValue == null ? Colors.grey.shade600 : ColorPack.black,
                  ),
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: ColorPack.black,
                ),
              ],
            ),
          ),
        ),

        // --- FIX #1: Conditionally build the list ---
        // This ensures the list (and its scrollbar) are only in the widget tree
        // when the dropdown is actually expanded.
        if (isExpanded)
          ExpandedSection(
            expand: isExpanded,
            height: 150,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: MyScrollbar(
                builder: (context, scrollController) => ListView.builder(
                  padding: EdgeInsets.zero,
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Text(
                        item,
                        style: tTextStyleRegular.copyWith(
                          fontSize: 16,
                          color: selectedValue == item
                              ? Colors.white
                              : ColorPack.darkGray,
                        ),
                      ),
                      selected: selectedValue == item,
                      selectedTileColor: ColorPack.iconOrange,
                      // --- FIX #2: Simplified onTap ---
                      // This now calls the onSelect callback from the parent,
                      // which handles both setting the value and closing the list.
                      onTap: () {
                        onSelect(item);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}