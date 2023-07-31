import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GNavBar extends StatelessWidget {
  const GNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GNav(
      haptic: false, // haptic feedback
      tabBorderRadius: 15,
      // tab button border
      tabBorder: Border.all(color: Colors.black, width: 1), // tab button border

      gap: 8,

      color: Colors.black, // unselected icon color
      activeColor: Colors.white, // selected icon and text color

      iconSize: 28,

      tabBackgroundColor: Colors.black, // selected tab background color
      padding: const EdgeInsets.all(16), // navigation bar padding
      mainAxisAlignment: MainAxisAlignment.center,
      tabMargin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      tabs: const [
        GButton(
          icon: Icons.auto_awesome_outlined,
          text: 'Home',
        ),
        GButton(
          icon: Icons.person_outline,
          text: 'Profile',
        ),
      ],
    );
  }
}
