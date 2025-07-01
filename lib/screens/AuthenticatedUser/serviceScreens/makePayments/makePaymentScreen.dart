import 'package:flutter/material.dart';
import 'package:local_government_app/screens/AuthenticatedUser/serviceScreens/makePayments/wastecollectionpayment.dart';
import 'package:local_government_app/screens/AuthenticatedUser/serviceScreens/makePayments/widgets/makePaymentCards.dart';
import 'package:local_government_app/utils/app_theme.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';
import 'package:local_government_app/widgets/expandlistwidget.dart';

// --- NEW: A class to hold both the text and the icon for a service ---
class ServiceItem {
  final String text;
  final IconData icon;
  final Color color; // The new property to hold the icon's color

  const ServiceItem({
    required this.text,
    required this.icon,
    required this.color, // Add it to the constructor
  });
}

class MakePayment extends StatefulWidget {
  const MakePayment({super.key});

  @override
  State<MakePayment> createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  // --- The list MUST be of type List<ServiceItem> ---
  final List<ServiceItem> _serviceList = [
    ServiceItem(
      text: "Waste Management",
      icon: Icons.delete_outline,
      color: ColorPack.green,
    ),
    ServiceItem(
      text: "Property Rate Tax",
      icon: Icons.house_outlined,
      color: ColorPack.discoverBlue,
    ),
    ServiceItem(
      text: "Rent(Assembly Property)",
      icon: Icons.store_mall_directory_outlined,
      color: ColorPack.red,
    ),
    ServiceItem(
      text: "Business Permit",
      icon: Icons.business_center_outlined,
      color: ColorPack.discoverYellow,
    ),
    ServiceItem(
      text: "Bill & Signpost Permit",
      icon: Icons.campaign_outlined,
      color: ColorPack.iconOrange,
    ),
  ];

  // --- The selected item variable MUST be of type ServiceItem? ---
  ServiceItem? _selectedServiceType;
  bool isServiceTypeExpanded = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              // ... Your other widgets remain the same ...
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
                          hintText: '',
                          selectedValue: _selectedServiceType,
                          items: _serviceList,
                          isExpanded: isServiceTypeExpanded,
                          controller: _scrollController,
                          onToggle: (isExpanded) {
                            setState(() {
                              isServiceTypeExpanded = isExpanded;
                            });
                          },
                          onSelect: (newValue) {
                            setState(() {
                              _selectedServiceType = newValue;
                              isServiceTypeExpanded = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              WasteCollectionPaymentFields()
              
            ],
          ),
        ),
      ),
    );
  }

  // --- The function signature MUST match the new types ---
  // The function signature MUST match the new types
  Widget _buildDropdown({
    required String hintText,
    required ServiceItem? selectedValue,
    required List<ServiceItem> items,
    required bool isExpanded,
    required ScrollController controller,
    required ValueChanged<bool> onToggle,
    required ValueChanged<ServiceItem?> onSelect,
  }) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            onToggle(!isExpanded);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.white,
              border: Border.all(color: ColorPack.darkGray),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (selectedValue == null)
                  Text(
                    hintText,
                    style: tTextStyleRegular.copyWith(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  )
                else
                  Row(
                    children: [
                      // --- CHANGE #1: Use the selected item's color for the icon ---
                      Icon(
                        selectedValue.icon,
                        color:
                            selectedValue.color, // Use the specific item color
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        selectedValue.text,
                        style: tTextStyleRegular.copyWith(
                          fontSize: 16,
                          color: ColorPack.black,
                        ),
                      ),
                    ],
                  ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: ColorPack.black,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          ExpandedSection(
            expand: isExpanded,
            height: 150,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 6.0,
                  radius: const Radius.circular(10),
                  controller: controller,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(right: 10),
                    controller: controller,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final bool isSelected = selectedValue == item;

                      // --- CHANGE #2: Logic to determine the icon and text color ---
                      // If selected, the icon is white. If not, it uses its own defined color.
                      final Color iconColor =
                          isSelected ? Colors.white : item.color;
                      // Keep text color consistent for readability.
                      final Color textColor =
                          isSelected ? Colors.white : ColorPack.darkGray;

                      return ListTile(
                        leading: Icon(
                          item.icon,
                          color: iconColor,
                        ), // Use the new iconColor
                        title: Text(
                          item.text,
                          style: tTextStyleRegular.copyWith(
                            fontSize: 16,
                            color: textColor, // Use the new textColor
                          ),
                        ),
                        selected: isSelected,
                        //selectedTileColor: ColorPack.iconOrange,
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
          ),
      ],
    );
  }
}
