import 'package:flutter/material.dart';
import 'package:local_government_app/utils/app_theme.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';
import 'package:local_government_app/widgets/components/buttons/primary_button.dart';
import 'package:local_government_app/widgets/components/inputfields/custom_field.dart';
import 'package:local_government_app/widgets/expandlistwidget.dart';

class BillSignpostFields extends StatefulWidget {
  const BillSignpostFields({super.key});

  @override
  State<BillSignpostFields> createState() => _BillSignpostFieldsState();
}

class _BillSignpostFieldsState extends State<BillSignpostFields> {
  TextEditingController signLocationController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  bool _obscureText = true;

  final List<String> _serviceList = [
    "Mobile Money",
    "Cedit/Debit Card",
    "Bank Transfer",
  ];

  final List<String> _signSizeList = [
    "Small (1x2ft)",
    "Medium (2x3ft)",
    "Large (3x4ft)",
  ];

  // --- The selected item variable MUST be of type ServiceItem? ---
  String? _selectedPaymentType;
  String? _selectedSignSize;
  bool isPaymentTypeExpanded = false;
  bool isSignSizeExpanded = false;

  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollSignSizeController = ScrollController();

  @override
  void dispose() {
    signLocationController.dispose();
    amountController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        right: size.width * 0.02,
        left: size.width * 0.02,
        top: size.height * 0.02,
        //bottom: size.height * 0.03,
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
          padding: EdgeInsets.only(
            left: size.width * 0.05,
            top: size.height * 0.04,
            right: size.width * 0.05,
            bottom: size.height * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.campaign_outlined,
                    color: ColorPack.iconOrange,
                    size: size.width * 0.06,
                  ),
                  SizedBox(width: size.width * 0.03),
                  Text(
                    "Bill & Signpost Permit Payment",
                    style: tTextStyleBold.copyWith(
                      color: ColorPack.black,
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              CustomInputField(
                controller: signLocationController,
                label: "Signpost Location",
                labelColor: ColorPack.black,
                placeholder: "Enter signpost location",
                height: 40,
                onTextChanged: (String str) {},
                textColor: ColorPack.black,
                obscureText: _obscureText,
                readOnly: false,
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                "Sign Size",
                style: tTextStyle600.copyWith(
                  color: ColorPack.black,
                  fontSize: size.width * 0.04,
                ),
              ),
              SizedBox(height: size.height * 0.005),
              _buildDropdown(
                hintText: 'Select sign size',
                selectedValue: _selectedPaymentType,
                items: _serviceList,
                isExpanded: isPaymentTypeExpanded,
                controller: _scrollController,
                onToggle: (isExpanded) {
                  setState(() {
                    isPaymentTypeExpanded = isExpanded;
                  });
                },
                onSelect: (newValue) {
                  setState(() {
                    _selectedPaymentType = newValue;
                    isPaymentTypeExpanded = false;
                  });
                },
              ),
              SizedBox(height: size.height * 0.01),
              CustomInputField(
                controller: amountController,
                label: "Amount (₵)",
                labelColor: ColorPack.black,
                placeholder: "0",
                height: 40,
                onTextChanged: (String str) {},
                textColor: ColorPack.black,
                obscureText: _obscureText,
                readOnly: false,
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                "Payment Method",
                style: tTextStyle600.copyWith(
                  color: ColorPack.black,
                  fontSize: size.width * 0.04,
                ),
              ),
              SizedBox(height: size.height * 0.005),
              _buildDropdown(
                hintText: 'Select payment method',
                selectedValue: _selectedSignSize,
                items: _signSizeList,
                isExpanded: isSignSizeExpanded,
                controller: _scrollSignSizeController,
                onToggle: (isExpanded) {
                  setState(() {
                    isSignSizeExpanded = isExpanded;
                  });
                },
                onSelect: (newValue) {
                  setState(() {
                    _selectedSignSize = newValue;
                    isSignSizeExpanded = false;
                  });
                },
              ),
              SizedBox(height: size.height * 0.04),
              PrimaryButton(
                onPressed: () {},
                text: "Proceed to Payment",
                buttonColor: ColorPack.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ... (all your existing code and imports above this)

  Widget _buildDropdown({
    required String hintText,
    required String? selectedValue,
    required List<String> items,
    required bool isExpanded,
    required ScrollController controller,
    required ValueChanged<bool> onToggle,
    required ValueChanged<String?> onSelect,
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
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 7,
            ), // Adjusted padding
            decoration: BoxDecoration(
              color: ColorPack.white,
              border: Border.all(color: ColorPack.black), // Softer border
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
                  // --- MODIFIED: Display the selected text when the dropdown is closed ---
                  Text(
                    selectedValue,
                    style: tTextStyleRegular.copyWith(
                      fontSize: 16,
                      color: ColorPack.black,
                    ),
                  ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey.shade700,
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
              margin: const EdgeInsets.only(top: 4), // Add margin
              decoration: BoxDecoration(
                border: Border.all(color: ColorPack.darkGray),
                borderRadius: BorderRadius.circular(8),
                color: ColorPack.white, // Explicitly set background
              ),
              child: Padding(
                padding: const EdgeInsets.all(4), // Padding for the list
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 6.0,
                  radius: const Radius.circular(10),
                  controller: controller,
                  child: ListView.builder(
                    padding:
                        EdgeInsets.zero, // Remove ListView's default padding
                    controller: controller,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final bool isSelected = selectedValue == item;

                      return ListTile(
                        selected: isSelected,
                        selectedTileColor: ColorPack.black.withOpacity(
                          0.1,
                        ), // Visual feedback for selection
                        onTap: () {
                          onSelect(item);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        // --- THIS IS THE FIX: Added the 'title' to show the item text ---
                        title: Text(
                          item,
                          style: tTextStyle500.copyWith(
                            color:
                                isSelected ? ColorPack.black : ColorPack.black,
                          ),
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
