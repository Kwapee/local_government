import 'package:flutter/material.dart';
import 'package:local_government_app/screens/AuthenticatedUser/serviceScreens/makePayments/widgets/transactionlistitems.dart';
import 'package:local_government_app/screens/AuthenticatedUser/serviceScreens/makePayments/widgets/transactionstatus.dart';
import 'package:local_government_app/utils/app_theme.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';

// Enum to manage which filter is currently active
enum FilterType { none, status, service }

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  final List<String> _statusList = ["Paid", "Pending", "Failed"];
  final List<String> _servicesList = [
    "Property Rate",
    "Business Permit",
    "Market Toll",
  ];

  String? _selectedStatus;
  bool isStatusExpanded = false;

  String? _selectedServices;
  bool isServicesExpanded = false;

  FilterType _activeFilter = FilterType.none;

  final ScrollController _scrollStatusController = ScrollController();
  final ScrollController _scrollServicesController = ScrollController();

  // --- NEW: LayerLink connects the button (Target) and the dropdown (Follower) ---
  final LayerLink _layerLink = LayerLink();

  @override
  void dispose() {
    _scrollStatusController.dispose();
    _scrollServicesController.dispose();
    super.dispose();
  }
  
  // --- NEW: A method to dismiss any open dropdown ---
  void _dismissDropdown() {
    if (isStatusExpanded || isServicesExpanded) {
      setState(() {
        isStatusExpanded = false;
        isServicesExpanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    // --- MODIFIED: The main layout is now a Stack ---
    return Stack(
      children: [
        // --- LAYER 1: The main content (background) ---
        // GestureDetector to close dropdown on background tap
        GestureDetector(
          onTap: _dismissDropdown,
          child: Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.02,
              right: size.width * 0.02,
              top: size.height * 0.03,
              //bottom: size.height * 0.03,
            ),
            child: Container(
              // The main white card
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.03,
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      bottom: size.height * 0.03,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment History",
                          style: tTextStyleBold.copyWith(
                            color: ColorPack.black,
                            fontSize: size.width * 0.045,
                          ),
                        ),
                        const Spacer(),
                        // --- MODIFIED: The filter button is now wrapped in a CompositedTransformTarget ---
                        CompositedTransformTarget(
                          link: _layerLink,
                          child: _buildFilterUi(),
                        ),
                      ],
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                       TransactionListItem(
                        title: "Waste Collection",
                        date: "2025-04-02",
                        amount: "₵120.00",
                        status: TransactionStatus.paid,
                        icon: Icons.recycling_outlined,
                        onDownloadTap: () => print("Download Paid receipt..."),
                      ),
                      TransactionListItem(
                        title: "Electricity Bill",
                        date: "2025-04-05",
                        amount: "₵75.50",
                        status: TransactionStatus.failed,
                        icon: Icons.lightbulb_outline,
                        onDownloadTap: () => print("Download Failed receipt..."),
                      ),
                      TransactionListItem(
                        title: "Water Bill",
                        date: "2025-04-10",
                        amount: "₵50.00",
                        status: TransactionStatus.pending,
                        icon: Icons.water_drop_outlined,
                        onDownloadTap: () => print("Download Pending receipt..."),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // --- LAYER 2: The Overlay (the dropdown list) ---
        // This will be positioned by the CompositedTransformFollower
        _buildOverlay(),
      ],
    );
  }

  // --- NEW: This widget builds the overlay that appears on top ---
  Widget _buildOverlay() {
    // If no dropdown is expanded, return an empty widget
    if (!isStatusExpanded && !isServicesExpanded) {
      return const SizedBox.shrink();
    }
    
    // Determine which list and selection to show
    final items = isStatusExpanded ? _statusList : _servicesList;
    final selectedValue = isStatusExpanded ? _selectedStatus : _selectedServices;
    final controller = isStatusExpanded ? _scrollStatusController : _scrollServicesController;

    return CompositedTransformFollower(
      link: _layerLink,
      // Aligns the top-right of the dropdown with the bottom-right of the button
      targetAnchor: Alignment.bottomRight,
      followerAnchor: Alignment.topRight,
      // Add a small vertical gap between the button and the list
      offset: const Offset(0, 4.0),
      child: Material( // Material is needed for elevation and correct rendering
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.35,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorPack.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 6.0,
              radius: const Radius.circular(10),
              controller: controller,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                controller: controller,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final bool isSelected = selectedValue == item;
                  return ListTile(
                    selected: isSelected,
                    selectedTileColor: ColorPack.black.withOpacity(0.1),
                    onTap: () {
                      setState(() {
                        if (isStatusExpanded) {
                          _selectedStatus = item;
                        } else {
                          _selectedServices = item;
                        }
                        // Close all dropdowns
                        isStatusExpanded = false;
                        isServicesExpanded = false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Text(
                      item,
                      style: tTextStyle500.copyWith(
                        color: ColorPack.black,
                        fontSize: MediaQuery.of(context).size.width * 0.025,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- MODIFIED: This method now only builds the button part of the UI ---
  Widget _buildFilterUi() {
    final size = MediaQuery.of(context).size;
    switch (_activeFilter) {
      case FilterType.status:
        return _buildDropdownButton(
          hintText: 'All Status',
          selectedValue: _selectedStatus,
          isExpanded: isStatusExpanded,
          onTap: () {
            setState(() {
              // Close other dropdowns and toggle this one
              isServicesExpanded = false;
              isStatusExpanded = !isStatusExpanded;
            });
          },
        );
      case FilterType.service:
        return _buildDropdownButton(
          hintText: 'All Services',
          selectedValue: _selectedServices,
          isExpanded: isServicesExpanded,
          onTap: () {
            setState(() {
              // Close other dropdowns and toggle this one
              isStatusExpanded = false;
              isServicesExpanded = !isServicesExpanded;
            });
          },
        );
      case FilterType.none:
      default:
        return PopupMenuButton<FilterType>(
          child: SizedBox(
            width: 27,
            height: 27,
            child: Image.asset("assets/images/menu-vertical.png"),
          ),
          offset: const Offset(0, 30),
          onSelected: (FilterType selectedFilter) {
            setState(() {
              _activeFilter = selectedFilter;
              _dismissDropdown(); // Close any open dropdowns when switching filters
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterType>>[
                PopupMenuItem<FilterType>(
                  value: FilterType.status,
                  child: Text(
                    'Filter by Status',
                    style: tTextStyle500.copyWith(
                      color: ColorPack.black,
                      fontSize: size.width * 0.03,
                    ),
                  ),
                ),
                PopupMenuItem<FilterType>(
                  value: FilterType.service,
                  child: Text(
                    'Filter by Service',
                    style: tTextStyle500.copyWith(
                      color: ColorPack.black,
                      fontSize: size.width * 0.03,
                    ),
                  ),
                ),
              ],
        );
    }
  }

  // --- MODIFIED: This is just the tappable button, no expanded list ---
  Widget _buildDropdownButton({
    required String hintText,
    required String? selectedValue,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.35,
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
        decoration: BoxDecoration(
          color: ColorPack.white,
          border: Border.all(color: ColorPack.black),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                selectedValue ?? hintText,
                style: tTextStyleRegular.copyWith(
                  fontSize: size.width * 0.025,
                  color: selectedValue == null
                      ? Colors.grey.shade600
                      : ColorPack.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.grey.shade700,
              size: size.width * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}