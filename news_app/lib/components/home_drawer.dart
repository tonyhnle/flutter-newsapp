import 'package:flutter/material.dart';
import '../views/login_page.dart';
class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Icon(Icons.favorite,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:25),
                  child: ListTile(
                    leading: Icon(Icons.home,
                        color: Theme.of(context).colorScheme.inversePrimary),
                    title: Text('H O M E'),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:25),
                  child: ListTile(
                    leading: Icon(Icons.person,
                        color: Theme.of(context).colorScheme.inversePrimary),
                    title: Text('P R O F I L E'),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:25),
                  child: ListTile(
                    leading: Icon(Icons.favorite,
                        color: Theme.of(context).colorScheme.inversePrimary),
                    title: Text('L I K E D'),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left:25),
              child: ListTile(
                leading: Icon(Icons.logout,
                    color: Theme.of(context).colorScheme.inversePrimary),
                title: Text('L O G O U T'),
                onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              )
              ),
            )
          ],
        ));
  }
}
