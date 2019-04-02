import 'package:dycky_most/Screens/Favorites.dart';
import 'package:dycky_most/Screens/Peoples.dart';
import 'package:dycky_most/Screens/Settings.dart';
import 'package:dycky_most/app.dart';
import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class MostDrawer extends StatefulWidget {
  final int selectedPage;
  final drawerPagesItems = [
    DrawerItem("Všechny hlášky", Icons.library_music),
    DrawerItem("Oblíbené hlášky", Icons.favorite),
  ];
  final drawerScreensItems = [DrawerItem("Nastavení", Icons.settings), DrawerItem("O aplikaci", Icons.info)];

  MostDrawer(this.selectedPage);

  @override
  MostDrawerState createState() => MostDrawerState();
}

class MostDrawerState extends State<MostDrawer> {
  onSelectFragment(int index) {
    if (index == widget.selectedPage) {
      Navigator.of(context).pop(); // close the drawer
      return;
    }

    Navigator.of(context).pop(); // close the drawer

    var page;
    switch (index) {
      case 0:
        page = PeoplesScreen(index);
        break;
      case 1:
        page = FavoritesScreen(index);
        break;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }

  onSelectScreen(int index) {
    Navigator.of(context).pop(); // close the drawer

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
        break;
      case 1:
        showDialog(
            context: context,
            builder: (context) {
              return AboutDialog(
                  applicationName: App.title,
                  applicationVersion: "Verze: 0.1",
                  applicationIcon: Image(
                    image: ExactAssetImage('assets/images/app_icon.png'),
                    width: 60.0,
                  ),
                  applicationLegalese: '© 2019 RED WOLF',
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: RichText(
                            text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                style: Theme.of(context).textTheme.body2,
                                text: 'Aplikace nemá nic společeného s Českou Televizí!\n\nJe '
                                    'vytvořená pro zábavu od fanoušků seriálu Most.\n\n'),
                            TextSpan(
                              style:  Theme.of(context).textTheme.body1,
                              text: 'Všechny použité loga, obrázky a hlášky náleží tvůrcům seriálu Most.'
                            )
                          ],
                        )))
                  ]);
            });
        break;
      default:
        return Text("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerPages = [];
    List<Widget> drawerScreens = [];

    for (var i = 0; i < widget.drawerPagesItems.length; i++) {
      var d = widget.drawerPagesItems[i];
      drawerPages.add(ListTile(
        leading: Icon(d.icon),
        title: Text(d.title),
        selected: i == widget.selectedPage,
        onTap: () => onSelectFragment(i),
      ));
    }

    for (var i = 0; i < widget.drawerScreensItems.length; i++) {
      var d = widget.drawerScreensItems[i];
      drawerScreens.add(ListTile(
        leading: Icon(d.icon),
        title: Text(d.title),
        onTap: () => onSelectScreen(i),
      ));
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/drawer_header.jpg'), fit: BoxFit.cover),
            ),
            child: null,
          ),
          Expanded(
              child: ListView(padding: EdgeInsets.all(0.0), children: <Widget>[
            Column(children: drawerPages),
            Divider(height: 1),
            Column(children: drawerScreens)
          ]))
        ],
      ),
    );
  }
}
