import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_government_app/utils/colors.dart';
import 'package:local_government_app/utils/typography.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isCompanypoliciesExpanded = false;

  bool _isDocumentmanagementExpanded = false;
  // bool _isRequisitionmanagementExpanded = false;

  bool _passcodeLogin = false;
  bool _setTheme = false;
  bool _isInfoExpanded = false;
  bool _isHelpExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: ColorPack.iconBeige,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: ColorPack.white,
            height: size.height * 0.15,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.08,
                left: size.width * 0.02,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      FontAwesomeIcons.xmark,
                      size: size.width * 0.045, // Responsive size
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.10),
                    child: Text(
                      "Perry Amoako",
                      style: tTextStyleBold.copyWith(
                        color: ColorPack.black,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountDetails(),
                        ),
                      );*/
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: size.width * 0.18),
                      child: CircleAvatar(
                        radius: size.width * 0.05, // Responsive size
                        /*backgroundImage: const AssetImage(
                          'assets/images/user.jpg',
                        ),*/
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorPack.white,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Column(
                          children: [
                            /*GestureDetector(
                              onTap: () {
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const AccountDetails(),
                                  ),
                                );*/
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: size.width * 0.05,
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: ColorPack.iconOrange,
                                      radius: size.width * 0.05,
                                      child: Icon(
                                        FontAwesomeIcons.user,
                                        color: ColorPack.black,
                                        size: size.width * 0.045,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.03),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.height * 0.01,
                                    ),
                                    child: Text(
                                      "User Details",
                                      style: TextStyle(
                                        fontSize: size.width * 0.045,
                                        color: ColorPack.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.height * 0.01,
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: size.width * 0.055,
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.025),
                                ],
                              ),
                            ),*/
                            //const CustomDivider(),

                            /*ExpandableTile(
                              size: size,
                              icon: Icons.policy,
                              title: "Company Policies",
                              isExpanded: _isCompanypoliciesExpanded,
                              onTap: () {
                                setState(() {
                                  _isCompanypoliciesExpanded =
                                      !_isCompanypoliciesExpanded;
                                });
                              },
                              content: Column(
                                children: [
                                  CustomListTile(
                                    size: size,
                                    title: "Notification Preferences",
                                    onTap: () {
                                      /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NotificationPreference(),
                                      ),
                                    );*/
                                    },
                                  ),
                                  const CustomDivider(),

                                  /*  CustomListTile(
                                  size: size,
                                  title: "Change currency",
                                  onTap: () {
                                   /* Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SelectCurrencies()));*/
                                  },
                                ),*/
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomListTile(
                                          size: size,
                                          title: "Mode",
                                          onTap: () {},
                                        ),
                                      ),
                                      /*Switch(
                                      value: Provider.of<ThemeProvider>(context)
                                          .themeData ==
                                          darkMode, // Assuming you have a property to check the current theme
                                      onChanged: (value) {
                                        Provider.of<ThemeProvider>(context,
                                            listen: false)
                                            .toggleTheme();
                                      },
                                    ),*/
                                    ],
                                  ),
                                ],
                              ),
                            ),*/

                            //const CustomDivider(),
                            /*ExpandableTile(
                              size: size,
                              icon: Icons.edit_document,
                              title: "Document Management",
                              isExpanded: _isDocumentmanagementExpanded,
                              onTap: () {
                                setState(() {
                                  _isDocumentmanagementExpanded =
                                      !_isDocumentmanagementExpanded;
                                });
                              },
                              content: Column(
                                children: [
                                  CustomListTile(
                                    size: size,
                                    title: "Notification Preferences",
                                    onTap: () {
                                      /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NotificationPreference(),
                                      ),
                                    );*/
                                    },
                                  ),
                                  const CustomDivider(),

                                  /*  CustomListTile(
                                  size: size,
                                  title: "Change currency",
                                  onTap: () {
                                   /* Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SelectCurrencies()));*/
                                  },
                                ),*/
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomListTile(
                                          size: size,
                                          title: "Mode",
                                          onTap: () {},
                                        ),
                                      ),
                                      /*Switch(
                                      value: Provider.of<ThemeProvider>(context)
                                          .themeData ==
                                          darkMode, // Assuming you have a property to check the current theme
                                      onChanged: (value) {
                                        Provider.of<ThemeProvider>(context,
                                            listen: false)
                                            .toggleTheme();
                                      },
                                    ),*/
                                    ],
                                  ),
                                ],
                              ),
                            ),*/
                            //const CustomDivider(),
                            /*ExpandableTile(
                              size: size,
                              icon: FontAwesomeIcons.questionCircle,
                              title: "HR Request and HelpDesk",
                              isExpanded: _isHelpExpanded,
                              onTap: () {
                                setState(() {
                                  _isHelpExpanded = !_isHelpExpanded;
                                });
                              },
                              content: Column(
                                children: [
                                  CustomListTile(
                                    size: size,
                                    title: "Contact us by phone",
                                    onTap: () {},
                                  ),
                                  const CustomDivider(),
                                  CustomListTile(
                                    size: size,
                                    title: "Contact us by email",
                                    onTap: () {},
                                  ),
                                  const CustomDivider(),
                                  CustomListTile(
                                    size: size,
                                    title: "FAQs",
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),*/
                            //const CustomDivider(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  /*Container(
                    padding: EdgeInsets.only(bottom: size.height * 0.55),
                    color: ColorPack.white,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to the new page
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            child: CircleAvatar(
                              backgroundColor: ColorPack.iconOrange,
                              radius: size.width * 0.05,
                              child: Icon(
                                FontAwesomeIcons.powerOff,
                                color: ColorPack.black,
                                size: size.width * 0.045,
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.01),
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: size.width * 0.045,
                                color: ColorPack.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableTile extends StatelessWidget {
  final Size size;
  final IconData icon;
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;
  final Widget content;

  const ExpandableTile({
    Key? key,
    required this.size,
    required this.icon,
    required this.title,
    required this.isExpanded,
    required this.onTap,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05),
                child: CircleAvatar(
                  backgroundColor: ColorPack.iconOrange,
                  radius: size.width * 0.05,
                  child: Icon(
                    icon,
                    color: ColorPack.black,
                    size: size.width * 0.045,
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.03),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.01),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    color: ColorPack.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: size.width * 0.08,
                color: ColorPack.black,
              ),
              SizedBox(width: size.width * 0.02),
            ],
          ),
          if (isExpanded) content,
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final Size size;
  final String title;
  final VoidCallback onTap;

  const CustomListTile({
    Key? key,
    required this.size,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: size.width * 0.04,
          color: ColorPack.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(color: Color.fromARGB(101, 54, 44, 44)),
    );
  }
}
