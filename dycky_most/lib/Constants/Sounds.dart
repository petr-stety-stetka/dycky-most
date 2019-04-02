import 'package:dycky_most/Model/Person.dart';
import 'package:dycky_most/Model/Sound.dart';

class Sounds {
  static final List<Sound> ludek = [
    Sound('Dneska Ti to sluší, Žanet!', ''),
    Sound('Cikáni nikdy nechoděj do práce dřív.', ''),
    Sound('To budeš mrkat na drát.', ''),
    Sound('Promiň drahá, nezlob se, ale je Ti vidět žlab.', ''),
    Sound('Ty s ní chodíš?', ''),
    Sound('Je fakt, že s takovouhle vahou ..', ''),
    Sound('Jsem tvůj fotr!', ''),
    Sound('Franto odpovídej ty, ty vole.', ''),
    Sound('Ty vole, já jdu do Pošty pro tebe, ruzumíš?', ''),
    Sound('Nezlobte se, já tohle musím říct.', ''),
    Sound('Já nevím, jestli vy víte ..', ''),
    Sound('A v neposlední řadě, nechceme ..', ''),
    Sound('DYCKY MOST!', ''),
    Sound('Tohle je prostě špatně.', ''),
    Sound('A proč lezeš do televize, ty vole?', ''),
    Sound('Ty buzno!', ''),
    Sound('Já Tě zabiju Pavle!', ''),
    Sound('Kurva to je můj kluk!', ''),
    Sound('Dobrý, dobrý, dobrý!', ''),
    Sound('No výborně vole, takže mistr přijde ..', ''),
  ];
  static final List<Sound> franta = [];
  static final List<Sound> roman = [];
  static final List<Sound> cockin = [];
  static final List<Sound> eda = [];
  static final List<Sound> farar = [];
  static final List<Sound> dasa = [];
  static final List<Sound> blanka = [];
  static final List<Sound> ilona = [];
  static final List<Sound> romana = [];
  static final List<Sound> zaneta = [];
  static final List<Sound> gerd = [];
  static final List<Sound> jozo = [];
  static final List<Sound> julis = [];
  static final List<Sound> julisova = [];
  static final List<Sound> laco = [];
  static final List<Sound> tonda = [];
  static final List<Sound> ruzne = [];

  static List<Sound> getSounds(Person person) {
    switch (person.path) {
      case 'ludek':
        return ludek;
      case 'franta':
        return franta;
      case 'roman':
        return roman;
      case 'cockin':
        return cockin;
      case 'eda':
        return eda;
      case 'farar':
        return farar;
      case 'dasa':
        return dasa;
      case 'blanka':
        return blanka;
      case 'ilona':
        return ilona;
      case 'romana':
        return romana;
      case 'zaneta':
        return zaneta;
      case 'gerd':
        return gerd;
      case 'jozo':
        return jozo;
      case 'julis':
        return julis;
      case 'julisova':
        return julisova;
      case 'laco':
        return laco;
      case 'tonda':
        return tonda;
      case 'ruzne':
        return ruzne;
      default:
        return null;
    }
  }
}
