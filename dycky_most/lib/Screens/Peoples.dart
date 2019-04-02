import 'package:dycky_most/Constants/Persons.dart';
import 'package:dycky_most/Model/Person.dart';
import 'package:dycky_most/Screens/PeopleDetail.dart';
import 'package:share/share.dart';
import 'package:dycky_most/Components/Drawer.dart';
import 'package:dycky_most/app.dart';
import 'package:flutter/material.dart';

class PeoplesScreen extends StatefulWidget {
  final int selectedPage;

  PeoplesScreen(this.selectedPage);

  @override
  PeoplesScreenState createState() => PeoplesScreenState();
}

class PeoplesScreenState extends State<PeoplesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(App.title), actions: null),
      drawer: MostDrawer(widget.selectedPage),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        padding: EdgeInsets.all(4.0),
        children: buildList(context),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.share),
        onPressed: () => shareApp(),
        tooltip: 'Sdílet aplikaci',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  shareApp() {
    Share.share('Poslechni si ty nejlepší hlášky ze seriálu Most https://play.google.com/store/apps/details?id=cz'
        '.redwolf.dyckymost'); //TODO iOS link
  }

  List<Widget> buildList(BuildContext context) {
    return Persons.persons.map((person) => buildListItem(person, context)).toList();
  }

  Widget buildListItem(Person person, BuildContext context) {
    return GridTile(
        footer: GestureDetector(
            onTap: () => openPeopleDetail(person),
            child: GridTileBar(
              backgroundColor: Colors.black45,
              title: Text(person.name),
            )),
        child: new InkResponse(
          enableFeedback: true,
          child: Hero(tag: person.path, child: Image.asset('assets/images/peoples/' + person.image, fit: BoxFit.cover)),
          onTap: () => openPeopleDetail(person),
        ));
  }

  openPeopleDetail(Person person) {
    return Navigator.push(context, MaterialPageRoute(builder: (context) => PeopleDetailScreen(person)));
  }
}
