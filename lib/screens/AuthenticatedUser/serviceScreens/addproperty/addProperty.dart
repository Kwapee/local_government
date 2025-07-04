import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';
import 'package:local_government_app/widgets/components/inputfields/custom_field.dart';
import 'package:local_government_app/widgets/expandlistwidget.dart';
import 'package:local_government_app/widgets/expandlistwidgetsmall.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({super.key});

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  TextEditingController propertyCodeController = TextEditingController();
  TextEditingController postaddressController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController propertyAddress1Controller = TextEditingController();
  TextEditingController propertyAddress2Controller = TextEditingController();
  TextEditingController numberUnitController = TextEditingController();

  bool _obscureText = true;

  Map<String, dynamic> regionsAndAssembliesData = {};

  // Lists to hold the data for the dropdowns
  List<String> _regionsList = [];
  List<String> _assembliesForSelectedRegion = [];
  List<String> _propertyTypeList = [];
  List<String> _propertyTierList = [];

  // State for selected values
  String? _selectedRegion;
  String? _selectedAssembly;
  String? _selectedPropertyType;
  String? _selectedPropertyTier;

  bool isRegionStrechedDropDown = false;
  bool isAssemblyStrechedDropDown = false;
  bool isPropertyTypeStrechedDropDown = false;
  bool isPropertyTierStrechedDropDown = false;

  String RegionType = 'Select Region';
  String AssemblyType = 'Select Assembly';
  String PropertyType = 'Select Property Type';
  String PropertyTier = 'Select Property Tier';

  final List<String> _serviceList = [
    "Mobile Money",
    "Cedit/Debit Card",
    "Bank Transfer",
  ];

  // --- The selected item variable MUST be of type ServiceItem? ---
  String? _selectedPaymentType;
  bool isPaymentTypeExpanded = false;

  final ScrollController _scrollController = ScrollController();
  final ScrollController _regionscrollController = ScrollController();
  final ScrollController _assemblyscrollController = ScrollController();
  final ScrollController _propertyTypescrollController = ScrollController();
  final ScrollController _propertyTierscrollController = ScrollController();

  @override
  void dispose() {
    propertyCodeController.dispose();
    postaddressController.dispose();
    amountController.dispose();
    _scrollController.dispose();
    _assemblyscrollController.dispose();
    propertyAddress1Controller.dispose();
    propertyAddress2Controller.dispose();
    numberUnitController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _loadRegionsData();
  }

  // 3. New asynchronous method to load and parse the JSON
  Future<void> _loadRegionsData() async {
    final String response = await rootBundle.loadString(
      'assets/data/regions_and_assemblies.json',
    );
    final data = await json.decode(response);

    setState(() {
      regionsAndAssembliesData = data;
      _regionsList = regionsAndAssembliesData.keys.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          color: const Color.fromARGB(153, 49, 49, 49),
          height: MediaQuery.of(context).size.height,
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.79, // Increased size to accommodate new fields
          minChildSize: 0.75,
          maxChildSize: 0.81,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: ColorPack.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.03,
                    right: size.width * 0.03,
                    top: size.height * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Register a Property",
                          style: tTextStyleBold.copyWith(
                            color: ColorPack.black,
                            fontSize: size.width * 0.04,
                          ),
                        ),
                      ),
                      SizedBox(height: size.width * 0.05),
                      CustomInputField(
                        controller: propertyCodeController,
                        label: 'Property Code',
                        labelColor: ColorPack.darkGray.withOpacity(0.7),
                        placeholder: 'Enter Property Code',
                        height: 40,
                        onTextChanged: (String str) {},
                        textColor: ColorPack.black,
                        obscureText: _obscureText,
                        readOnly: true,
                      ),
                      SizedBox(height: size.width * 0.03),
                      CustomInputField(
                        controller: postaddressController,
                        label: 'Ghana Post Address',
                        labelColor: ColorPack.darkGray.withOpacity(0.7),
                        placeholder: 'Enter Porperty Ghana Post Address',
                        height: 40,
                        onTextChanged: (String str) {},
                        textColor: ColorPack.black,
                        obscureText: _obscureText,
                        readOnly: false,
                      ),
                      SizedBox(height: size.width * 0.03),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Region Located In",
                            style: tTextStyle600.copyWith(
                              fontSize: size.width * 0.04,
                              color: ColorPack.darkGray.withOpacity(0.7),
                            ),
                          ),
                          SizedBox(width: size.width * 0.13),
                          Text(
                            "Assembly Located In",
                            style: tTextStyle600.copyWith(
                              fontSize: size.width * 0.04,
                              color: ColorPack.darkGray.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.width * 0.01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildDropdown(
                              hintText: 'Select Region',
                              selectedValue: _selectedRegion,
                              items: _regionsList,
                              isExpanded: isRegionStrechedDropDown,
                              onToggle: (isExpanded) {
                                setState(() {
                                  isRegionStrechedDropDown = isExpanded;
                                  isAssemblyStrechedDropDown =
                                      false; // Close other dropdown
                                });
                              },
                              onSelect: (newValue) {
                                setState(() {
                                  _selectedRegion = newValue;
                                  _selectedAssembly =
                                      null; // IMPORTANT: Reset assembly when region changes
                                  _assembliesForSelectedRegion =
                                      List<String>.from(
                                        regionsAndAssembliesData[newValue!] ??
                                            [],
                                      );
                                  isRegionStrechedDropDown = false;
                                });
                              },
                              controller: _regionscrollController,
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Expanded(
                            child: _buildDropdown(
                              hintText: 'Select Assembly',
                              selectedValue: _selectedAssembly,
                              items: _assembliesForSelectedRegion,
                              isExpanded: isAssemblyStrechedDropDown,
                              onToggle: (isExpanded) {
                                setState(() {
                                  isAssemblyStrechedDropDown = isExpanded;
                                  isRegionStrechedDropDown =
                                      false; // Close other dropdown
                                });
                              },
                              onSelect: (newValue) {
                                setState(() {
                                  _selectedAssembly = newValue;
                                  isAssemblyStrechedDropDown = false;
                                });
                              },
                              controller: _regionscrollController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.width * 0.03),

                      CustomInputField(
                        controller: propertyAddress1Controller,
                        label: "Property Address Line 1",
                        labelColor: ColorPack.darkGray.withOpacity(0.7),
                        placeholder: "Enter Property Address Line 1",
                        height: 40,
                        onTextChanged: (String str) {},
                        textColor: ColorPack.black,
                        obscureText: _obscureText,
                        readOnly: false,
                      ),
                      SizedBox(height: size.width * 0.03),
                      CustomInputField(
                        controller: propertyAddress2Controller,
                        label: "Property Address Line 2",
                        labelColor: ColorPack.darkGray.withOpacity(0.7),
                        placeholder: "Enter Property Address Line 2",
                        height: 40,
                        onTextChanged: (String str) {},
                        textColor: ColorPack.black,
                        obscureText: _obscureText,
                        readOnly: false,
                      ),
                      SizedBox(height: size.width * 0.03),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Property Type",
                            style: tTextStyle600.copyWith(
                              fontSize: size.width * 0.04,
                              color: ColorPack.darkGray.withOpacity(0.7),
                            ),
                          ),
                          SizedBox(width: size.width*0.2,),
                          Text(
                            "Property Tier",
                            style: tTextStyle600.copyWith(
                              fontSize: size.width * 0.04,
                              color: ColorPack.darkGray.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.width * 0.01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildDropdown(
                              hintText: 'Select Property Type',
                              selectedValue: _selectedPropertyType,
                              items: _propertyTypeList,
                              isExpanded: isPropertyTypeStrechedDropDown,
                              onToggle: (isExpanded) {
                                setState(() {
                                  isPropertyTypeStrechedDropDown = isExpanded;
                                  // Close other dropdown
                                });
                              },
                              onSelect: (newValue) {
                                setState(() {
                                  _selectedPropertyType = newValue;
                                  // IMPORTANT: Reset assembly when region changes

                                  isPropertyTypeStrechedDropDown = false;
                                });
                              },
                              controller: _propertyTypescrollController,
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Expanded(
                            child: _buildDropdown(
                              hintText: 'Select Property Tier',
                              selectedValue: _selectedPropertyTier,
                              items: _propertyTierList,
                              isExpanded: isPropertyTierStrechedDropDown,
                              onToggle: (isExpanded) {
                                setState(() {
                                  isPropertyTierStrechedDropDown = isExpanded;
                                 // Close other dropdown
                                });
                              },
                              onSelect: (newValue) {
                                setState(() {
                                  _selectedPropertyTier= newValue;
                                  //isAssemblyStrechedDropDown = false;
                                });
                              },
                              controller: _propertyTierscrollController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.width * 0.03),
                      CustomInputField(
                        controller: numberUnitController,
                        label: "Number of Units",
                        labelColor: ColorPack.darkGray.withOpacity(0.7),
                        placeholder: "Enter number of building units",
                        height: 40,
                        onTextChanged: (String str) {},
                        textColor: ColorPack.black,
                        obscureText: _obscureText,
                        readOnly: false,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String hintText,
    required String? selectedValue,
    required List<String> items,
    required bool isExpanded,
    required ScrollController controller,
    required ValueChanged<bool> onToggle,
    required ValueChanged<String?> onSelect,
  }) {
    final size = MediaQuery.of(context).size;
    bool isDisabled =
        (hintText == 'Select Assembly' && _selectedRegion == null);
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            onToggle(!isExpanded);
          },
          child: Container(
            width: double.infinity,
            height: 40,
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
                      fontSize: size.width * 0.03,
                      color: Colors.grey.shade600,
                    ),
                  )
                else
                  // --- MODIFIED: Display the selected text when the dropdown is closed ---
                  Text(
                    selectedValue,
                    style: tTextStyleRegular.copyWith(
                      fontSize: size.width * 0.03,
                      color: ColorPack.black,
                    ),
                  ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey.shade700,
                  size: size.width * 0.035,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          ExpandedSectionAdjust(
            expand: isExpanded,
            //height: 150,
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
