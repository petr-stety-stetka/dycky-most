import 'package:dycky_most/Components/Drawer.dart';
import 'package:dycky_most/Constants/Sounds.dart';
import 'package:dycky_most/Model/Person.dart';
import 'package:dycky_most/Model/Sound.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  final int selectedPage;

  FavoritesScreen(this.selectedPage);

  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  var sounds = Sounds.getSounds(Person('Luděk', 'ludek', 'ludek.jpg'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Oblíbené hlášky'),
          actions: <Widget>[],
        ),
        drawer: MostDrawer(widget.selectedPage),
        body:
            /* ListView.builder(
            itemBuilder: (context, index) {
              return buildListItem(sounds[index]);
            },
          itemCount: sounds.length,
        )*/
            Padding(
          padding: const EdgeInsets.all(4.0),
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            padding: EdgeInsets.all(4.0),
            children: //buildGridItem(context),
                sounds.map((sound) => buildGridItem(sound)).toList(),
          ),
        ));
  }

  Widget buildGridItem(Sound sound) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(
              children: <Widget>[
                Center(
                    child: Text(
                  sound.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
                Text('luděk'),
                PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    onSelected: onMenuItemSelected,
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                          value: 'Add to favorites',
                          child: ListTile(leading: Icon(Icons.favorite_border), title: Text('Přidat do oblíbených'))),
                      const PopupMenuItem<String>(
                          value: 'Share', child: ListTile(leading: Icon(Icons.person_add), title: Text('Sdílet'))),
                    ]),
              ],
            ))
    );
  }

  Widget buildListItem(Sound sound) {
    return ListTile(
      leading: Image.asset(
        'assets/images/peoples/ludek.jpg', // + widget.person.image,
        fit: BoxFit.cover,
        width: 40,
      ),
      title: Text(sound.name),
      subtitle: Text('Luděk'),
      trailing: PopupMenuButton<String>(
          padding: EdgeInsets.zero,
          onSelected: onMenuItemSelected,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                    value: 'Remove from favorites',
                    child: ListTile(leading: Icon(Icons.favorite_border), title: Text('Odstranit z oblíbených'))),
                const PopupMenuItem<String>(
                    value: 'Share', child: ListTile(leading: Icon(Icons.person_add), title: Text('Sdílet'))),
              ]),
      onTap: () {},
    );
  }

  void onMenuItemSelected(String value) {}
}
