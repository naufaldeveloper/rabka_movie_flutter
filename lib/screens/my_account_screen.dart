import 'package:rabka_movie/provider/drawer_toggle_provider.dart';
import 'package:rabka_movie/responsive/mobile_screen_layout.dart';
import 'package:rabka_movie/responsive/responsive_layout.dart';
import 'package:rabka_movie/responsive/web_screen_layout.dart';
import 'package:rabka_movie/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAccountScreen extends StatefulWidget {
  final userData;
  const MyAccountScreen({
    super.key,
    required this.userData,
  });

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  late var userData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    userData = widget.userData!;
  }

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
        (route) => false,
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error during sign out: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final toggleProvider = Provider.of<DrawerToggleProvider>(context);
    bool _toggleValue = toggleProvider.toggleValue;

    return isLoading
        ? Container(
            color: bgPrimaryColor,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_back_ios,
                            color: primaryColor,
                          ),
                          Text(
                            "My Account",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _toggleValue
                                  ? bgSecondaryColor
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: bgSecondaryColor,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(
                            userData['photoUrl'],
                          ),
                          backgroundColor: primaryColor,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          userData['username'],
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          userData['email'],
                        ),
                        const SizedBox(height: 24),
                        const SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Subscribed to Disney+ Hotstar Annual Rp199.OOO/Annual",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: secondaryColor,
                                  ),
                                ),
                                Text(
                                  "Next billing date: 07 October 2023",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cancel Subscription",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: _toggleValue
                                  ? bgSecondaryColor
                                  : Colors.black),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: secondaryColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: bgSecondaryColor,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20, top: 15, bottom: 10),
                      child: Text(
                        "Already paid? Try restoring subscription",
                        style: TextStyle(
                          fontSize: 11,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      "Restore Subscription",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color:
                              _toggleValue ? bgSecondaryColor : Colors.black),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 24,
                    color: bgSecondaryColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      "Preferences",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color:
                              _toggleValue ? bgSecondaryColor : Colors.black),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 24,
                    color: bgSecondaryColor,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 15, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _signOut();
                          },
                          child: const Text(
                            "Log Out",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.red),
                          ),
                        ),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: secondaryColor.withOpacity(0.3),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        const Text(
                          "Log Out All Devices",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.red),
                        ),
                        Container(
                          height: 1,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        const Text(
                          "Delete Account",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: bgSecondaryColor,
                      // height: 100, // hapus height agar menyesuaikan sisa layar
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
