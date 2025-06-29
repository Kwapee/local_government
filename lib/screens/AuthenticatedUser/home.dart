// import 'package:employer_self_service/utils/typography.dart'; // typography.dart was not used, can be removed if not needed elsewhere
import 'package:flutter/material.dart';
import 'package:local_government_app/screens/AuthenticatedUser/widget/drawer.dart';
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

class Home extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Home({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // The structure of Home widget is kept as is, assuming it's intentional for future content.
    // If it's only for the menu icon, it could be simplified.
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align content to the start
          children: [
            // This Stack + Padding + Column structure for a single IconButton is a bit verbose.
            // Simplified to just Padding + IconButton if no stacking elements are planned.
            // However, keeping original structure for now as requested was "fix bug".
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.01,
                    top: size.width * 0.02,
                  ), // Added a bit of top padding for visual appeal
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          scaffoldKey.currentState?.openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: ColorPack.black.withOpacity(0.5),
                          size: size.width * 0.08,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 12,
                              backgroundImage: AssetImage(
                                'assets/images/gov_header_img.png',
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(width: size.width * 0.02),
                            Expanded(
                              // Use Expanded to handle long text
                              child: Text(
                                "Accra Metropolitan Assembly",
                                style: tTextStyle500.copyWith(
                                  color: ColorPack.black,
                                  fontSize: size.width * 0.04,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width * 0.60,
                        height: size.height * 0.20,
                        decoration: BoxDecoration(
                          color: ColorPack.white,
                          border: Border.all(color: ColorPack.darkGray),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: ColorPack.boxShadow,
                              blurRadius: 2.0,
                              offset: const Offset(0, -2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text("Active Request"), Text("2")],
                                ),
                                CircleAvatar(
                                  // Set a radius to define the size of the circle
                                  radius: 40, // Example size, adjust as needed
                                  // Optional: A background color for the area not covered by the image
                                  backgroundColor: Colors.grey.shade200,

                                  // Use the 'child' property instead of 'backgroundImage'
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/request-active.png',

                                      // Here you can specify the fit!
                                      fit: BoxFit.contain,

                                      // It's good practice to provide a width and height
                                      // to ensure the image is contained properly.
                                      width:
                                          20, // Slightly smaller than radius * 2
                                      height: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Future content for the Home page can be added here within the outer Column
            // For example:
            // Padding(
            //   padding: EdgeInsets.all(size.width * 0.04),
            //   child: Text("Welcome to Home Page!", style: TextStyle(fontSize: 18)),
            // )
          ],
        ),
      ),
    );
  }
}
