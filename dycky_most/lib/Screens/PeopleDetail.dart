import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:dycky_most/Constants/Colors.dart';
import 'package:dycky_most/Constants/Sounds.dart';
import 'package:dycky_most/Model/Person.dart';
import 'package:dycky_most/Model/Sound.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class PeopleDetailScreen extends StatefulWidget {
  final Person person;

  PeopleDetailScreen(this.person);

  @override
  PeopleDetailScreenState createState() => PeopleDetailScreenState();
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class PeopleDetailScreenState extends State<PeopleDetailScreen> {
  AudioPlayer player = new AudioPlayer();
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;
  final double _appBarHeight = 256.0;

  //List<String> _favorites = PrefService.getListString('favorites') ?? List<String>();

  //bool get favorite => _favorites.contains(widget.recipe.id);

  /*set favorite(bool val) {
      if (val)
        _favorites.add(widget.recipe.id);
      else
        _favorites.remove(widget.recipe.id);

    PrefService.setListString('favorites', _favorites);
  }*/

  @override
  Widget build(BuildContext context) {
    var favorite = true;
    var textHeaderStyle = TextStyle(color: mainColor, fontSize: 15, fontWeight: FontWeight.w500);

    var favorites = Sounds.getSounds(Person('Luděk', 'ludek', 'ludek.jpg'));

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: _appBarHeight,
            pinned: _appBarBehavior == AppBarBehavior.pinned,
            floating: _appBarBehavior == AppBarBehavior.floating || _appBarBehavior == AppBarBehavior.snapping,
            snap: _appBarBehavior == AppBarBehavior.snapping,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.person.name),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Hero(
                    tag: widget.person.path,
                    child: Image.asset(
                      'assets/images/peoples/' + widget.person.image,
                      fit: BoxFit.cover,
                      height: _appBarHeight,
                    ),
                  ),
                  // This gradient ensures that the toolbar icons are distinct
                  // against the background image.
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.4),
                        colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      children: (widget.person.description == null)
                          ? <Widget>[getAllSoundsCard(textHeaderStyle)]
                          : <Widget>[
                              Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                      child: ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.only(top: 4, bottom: 12),
                                          child: Text(
                                            'O postavě',
                                            style: textHeaderStyle,
                                          ),
                                        ),
                                        subtitle: Text(widget.person.description),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                  child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      'Oblíbené hlášky',
                                      style: textHeaderStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: /*GridView.count(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 4,
                                      padding: EdgeInsets.all(4.0),
                                      children: //buildGridItem(context),
                                      favorites.map((sound) => buildGridItem(sound)).toList(),
                                    ),*/null
                                  )
                                ],
                              )),
                              getAllSoundsCard(textHeaderStyle),
                            ]),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  Widget buildGridItem(Sound sound) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
          child: Text(
        sound.name,
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      )),
    ));
  }

  Widget getAllSoundsCard(textHeaderStyle) {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Všechny hlášky',
            style: textHeaderStyle,
          ),
        ),
        Column(children: Sounds.getSounds(widget.person).map((sound) => buildListItem(sound)).toList())
      ],
    ));
  }

  Widget buildListItem(Sound sound) {
    return ListTile(
      title: Text(sound.name),
      trailing: PopupMenuButton<String>(
          padding: EdgeInsets.zero,
          onSelected: onMenuItemSelected,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                    value: 'Add to favorites',
                    child: ListTile(leading: Icon(Icons.favorite_border), title: Text('Přidat do oblíbených'))),
                const PopupMenuItem<String>(
                    value: 'Share', child: ListTile(leading: Icon(Icons.person_add), title: Text('Sdílet'))),
              ]),
      onTap: () {},
    );
  }

  void onMenuItemSelected(String value) {
    /*if (<String>[_simpleValue1, _simpleValue2, _simpleValue3].contains(value))
      _simpleValue = value;*/
    //Scaffold.of(context).showSnackBar(SnackBar(content: Text('You selected: $value')));
  }

  /* List<RaisedButton> createSoundsButtons() {
    var buttons = List<RaisedButton>();

    for (int i = 0; i < audioFiles.length; i++) {
      buttons.add(RaisedButton(
          padding: EdgeInsets.all(8),
          child: Text(
            audioNames[i],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          color: primaryColors[i],
          elevation: 4.0,
          splashColor: Theme
              .of(context)
              .brightness == Brightness.dark ? splashColors[i] : splashColorsLight[i],
          onPressed: () {
            if (i != lastButton) {
              lastPlayers.forEach((player) => player.stop());
              lastPlayers.clear();
            }

            playLocalAudio(audioFiles[i]);
            lastButton = i;
          }));
    }

    return buttons;
  }*/

  playLocalAudio(file) async {
    AudioCache player = new AudioCache();

    player.play('audio/' + file);
    //lastPlayers.add(await player.play('audio/' + file));
  }

  shareAudioFile(file) async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = directory.path + '/' + file;
    ByteData data = await rootBundle.load('assets/audio/' + file);
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var testFile = await File(dbPath).writeAsBytes(bytes);

    //File testFile = new File("${dir.path}/flutter/test.txt");

    if (!await testFile.exists()) {
      print('ERROR file doesn exit for share');
    }
    ShareExtend.share(testFile.path, "file");
  }
}
