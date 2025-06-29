// import 'package:employer_self_service/utils/typography.dart'; // typography.dart was not used, can be removed if not needed elsewhere
import 'package:flutter/material.dart';
import 'package:local_government_app/screens/AuthenticatedUser/widget/drawer.dart';
import 'package:local_government_app/screens/AuthenticatedUser/widget/homeCardPayment.dart';
import 'package:local_government_app/screens/AuthenticatedUser/widget/homeCards.dart';
import 'package:local_government_app/screens/AuthenticatedUser/widget/recentActivityCard.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // font_awesome_flutter was not used

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final List<Widget> pages;
  bool _isLoading = true; // Add loading state

  final ScrollController _scrollController = ScrollController();

  // 2. Remember to dispose of the controller to prevent memory leaks!
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState(); // BUG FIX: Added missing super.initState()
    // Simulate loading (replace with your actual data loading)
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // BUG FIX: Added mounted check before calling setState
        setState(() {
          _isLoading = false;
        });
      }
    });

    pages = [
      Home(scaffoldKey: _scaffoldKey),
      //const Services(),
      //const Notifications(),
      //const Settings(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: SizedBox(
        width: size.width * 0.85,
        child: const CustomDrawer(),
      ), // Added Drawer
      backgroundColor: ColorPack.white,
      body:
          _isLoading
              ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(ColorPack.red),
                ),
              )
              : SafeArea(
                bottom: false,
                child: IndexedStack(index: currentIndex, children: pages),
              ),
      bottomNavigationBar: Container(
        height: size.height * 0.11, // Responsive height for bottom navigation
        decoration: BoxDecoration(
          color: ColorPack.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: ColorPack.boxShadow,
              blurRadius: 2.0,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          elevation: 0, // To ensure container's shadow is primary
          color: Colors.transparent,
          child: Padding(
            // IMPROVEMENT: Use Padding directly, removed redundant Stack
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
            ), // IMPROVEMENT: Symmetrical padding
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround, //Distributes items evenly
              crossAxisAlignment:
                  CrossAxisAlignment
                      .center, // IMPROVEMENT: Center items vertically
              children: [
                tabItem(
                  Image.asset("assets/images/home.png", fit: BoxFit.contain),
                  "Home",
                  0,
                ),
                tabItem(
                  Image.asset(
                    "assets/images/customer-service_icon.png",
                    fit: BoxFit.contain,
                  ),
                  "Services",
                  1,
                ),
                tabItem(
                  Image.asset(
                    "assets/images/notification_icon.png",
                    fit: BoxFit.contain,
                  ),
                  "Notification",
                  2,
                ),
                tabItem(
                  Image.asset("assets/images/user.png", fit: BoxFit.contain),
                  "User",
                  3,
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget tabItem(Image imageWidget, String label, int index) {
    final size = MediaQuery.of(context).size;
    final bool isSelected = currentIndex == index;
    final Color activeColor =
        ColorPack.red; // IMPROVEMENT: Use ColorPack.red for consistency
    final Color inactiveColor = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: () => onTapTapped(index),
      behavior: HitTestBehavior.opaque, // Ensures the whole area is tappable
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            MainAxisAlignment
                .center, // Center content within the allocated space
        children: [
          SizedBox(
            // To control the size of the passed-in Image widget
            width: size.width * 0.07,
            height: size.width * 0.07,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                isSelected ? activeColor : inactiveColor,
                BlendMode.srcIn, // Apply color as a tint
              ),
              child: imageWidget, // The Image widget instance you passed
            ),
          ),
          SizedBox(height: size.width * 0.01), // Optional spacing
          Text(
            label,
            style: TextStyle(
              fontSize: size.width * 0.028,
              fontWeight: FontWeight.bold,
              color: isSelected ? activeColor : inactiveColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void onTapTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

class Home extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Home({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // 1. Create the ScrollController for the recent activity list
  final ScrollController _activityScrollController = ScrollController();

  // 2. Dispose of the controller when the widget is removed
  @override
  void dispose() {
    _activityScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.01,
                    top: size.width * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          // 3. Access the scaffoldKey via widget.scaffoldKey
                          widget.scaffoldKey.currentState?.openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: ColorPack.black.withOpacity(0.5),
                          size: size.width * 0.08,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.02,
                          left: size.width * 0.01,
                          right: size.width * 0.01,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomCard(
                                  title: 'Active Requests',
                                  subtitle: '3',
                                  icon: 'assets/images/request-active.png',
                                  number: '+1',
                                  numDescription: 'This Week',
                                  // avatarColor property was missing in the original call, added for completeness
                                  avatarColor: ColorPack.discoverBlue,
                                ),
                                SizedBox(width: size.width * 0.02),
                                CustomCard(
                                  title: 'Pending Requests',
                                  subtitle: '12',
                                  icon: 'assets/images/pending-actions.png',
                                  number: '+3',
                                  numDescription: 'This Month',
                                  avatarColor: ColorPack.iconOrange,
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomCardPayment(
                                  title: 'Payments Made',
                                  subtitle: 'GHC 200',
                                  icon: 'assets/images/payment.png',
                                  numDescription: 'This Month',
                                  avatarColor: ColorPack.badge2,
                                ),
                                SizedBox(width: size.width * 0.02),
                                CustomCardPayment(
                                  title: 'Total Payment Due',
                                  subtitle: 'July',
                                  icon: 'assets/images/payment_due.png',
                                  numDescription: 'Property Tax',
                                  avatarColor: ColorPack.badgeFont2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // In your _HomeState build method
                      Padding(
                        padding:  EdgeInsets.only(top: size.height*0.05, left: size.width*0.01, right: size.width*0.01),
                        child: Container(
                          width: size.width * 0.95,
                          height: size.height * 0.30,
                          padding: const EdgeInsets.fromLTRB(
                            16,
                            16,
                            8,
                            16,
                          ), // Adjust padding for scrollbar
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
                          // The main layout is still a Column
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // --- START OF FIX ---
                        
                              // 1. This Text widget is now a direct child of the Column,
                              //    so it will NOT be part of the scrollable area.
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 8.0,
                                ), // Match inner padding
                                child: Text(
                                  "Recent Activity",
                                  style: tTextStyleBold.copyWith(
                                    color: ColorPack.black,
                                    fontSize: size.width * 0.04,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                        
                              // 2. Wrap the scrollable part in Expanded. This makes it
                              //    take up all the remaining vertical space in the card.
                              Expanded(
                                child: Scrollbar(
                                  thumbVisibility: true,
                                  thickness: 6.0,
                                  radius: const Radius.circular(10),
                                  controller: _activityScrollController,
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    controller: _activityScrollController,
                                    // 3. This Column now ONLY contains the items you want to scroll.
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomRecentActivityCard(
                                          title: "Property Tax Payment",
                                          description:
                                              "Payment of 120 processed successfully",
                                          date: "2 hours ago",
                                          image: "assets/images/property_img.png",
                                        ),
                                        const SizedBox(height: 12),
                                        CustomRecentActivityCard(
                                          title: "Waste Pickup Request",
                                          description:
                                              "Scheduled for tomorrow morning",
                                          date: "1 day ago",
                                          image: "assets/images/waste_img.png",
                                        ),
                                        const SizedBox(height: 12),
                                        CustomRecentActivityCard(
                                          title: "Water Leakage Report",
                                          description:
                                              "Under investigation by maintenance team",
                                          date: "3 day ago",
                                          image:
                                              "assets/images/water_leakage.png",
                                        ),
                                        const SizedBox(height: 12),
                                        CustomRecentActivityCard(
                                          title: "Business Permit Application",
                                          description: "Process Ongoing",
                                          date: "4 day ago",
                                          image:
                                              "assets/images/business_permit.png",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // --- END OF FIX ---
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
