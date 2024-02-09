import 'package:rabka_movie/provider/drawer_toggle_provider.dart';
import 'package:rabka_movie/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

class TopNav extends StatelessWidget implements PreferredSizeWidget {
  final AdvancedDrawerController advancedDrawerController;

  const TopNav({
    super.key,
    required this.advancedDrawerController,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    bool _toggleValue = Provider.of<DrawerToggleProvider>(context).toggleValue;

    return AppBar(
      backgroundColor: _toggleValue == true ? Colors.black87 : bgPrimaryColor,
      title: Text(
        'Rabka Movie',
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: _toggleValue == true ? bgPrimaryColor : Colors.black87),
      ),
      centerTitle: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: IconButton(
          icon: ValueListenableBuilder<AdvancedDrawerValue>(
            valueListenable: advancedDrawerController,
            builder: (_, value, __) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Icon(
                  value.visible ? Icons.clear : Icons.menu,
                  key: ValueKey<bool>(value.visible),
                  color: _toggleValue == true ? bgPrimaryColor : Colors.black87,
                ),
              );
            },
          ),
          onPressed: () {
            advancedDrawerController.showDrawer();
          },
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: IconButton(
            icon: const Icon(Icons.search, size: 25),
            color: _toggleValue == true ? bgPrimaryColor : Colors.black87,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
