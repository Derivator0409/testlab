# TestLab — Flutter demo app tesztelési célra

Egy szándékosan sokféle, tesztelhető elemet tartalmazó Flutter alkalmazás.
Kézi QA-hoz, widget/integration teszt gyakorláshoz vagy automatizált
teszteléshez (pl. Appium, Maestro) is jól használható.

## Funkciók (mind tesztelhető)

| Képernyő      | Mit tesztelhetsz vele                                       |
|---------------|-------------------------------------------------------------|
| Bejelentkezés | Űrlap-validáció, hibaüzenetek, aszinkron submit, navigáció  |
| Számláló      | Állapotkezelés, gombnyomás, nullázás                        |
| Teendők       | Lista, hozzáadás, kipipálás, törlés (swipe)                 |
| Adatok        | Aszinkron betöltés: loading / siker / hiba állapotok        |
| Beállítások   | Switch, Slider, Dropdown, állapot megőrzése                 |

## Widget kulcsok (Key-ek) automatizáláshoz

Minden fontos interaktív elemnek van `Key`-e, pl.:
`email_field`, `password_field`, `login_button`, `counter_value`,
`increment`, `decrement`, `reset`, `todo_input`, `add_todo`,
`todo_checkbox_$i`, `load_data`, `load_error`, `loading`, `data_list`,
`switch_notifications`, `switch_dark`, `volume_slider`,
`language_dropdown`, `bottom_nav`, `logout_button`.

## Indítás

```bash
# 1. Projekt inicializálása a platform-mappákhoz (android/ios/web)
flutter create .

# 2. Függőségek
flutter pub get

# 3. Futtatás
flutter run
```

> A `flutter create .` a meglévő `lib/` és tesztfájlokat nem írja felül,
> csak a hiányzó platform-mappákat generálja.

## Tesztek futtatása

```bash
# Unit + widget tesztek
flutter test

# Integration teszt (emulátoron / eszközön)
flutter test integration_test/app_test.dart
```

## iOS szimulátorban futtatás Mac-en

iOS-hez **Mac + teljes Xcode** kell (a Command Line Tools önmagában nem elég,
mert a `simctl` csak az Xcode része).

### Előfeltételek (egyszer)

```bash
# Van teljes Xcode? (kell látnod: Xcode.app)
ls /Applications | grep -i Xcode

# Az aktív fejlesztői útvonal az Xcode-ra mutasson, ne a CommandLineTools-ra
xcode-select -p
# ha /Library/Developer/CommandLineTools jön ki, állítsd át:
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license accept

# iOS szimulátor-runtime letöltése (ha még nincs)
xcodebuild -downloadPlatform iOS

# Ellenőrzés – ki kell írnia a súgót:
xcrun simctl help
```

### A) A projekt lebuildelése és futtatása szimulátoron (helyi kód)

Ez a leggyorsabb út, ha a forrás megvan a gépeden:

```bash
open -a Simulator          # indíts egy iPhone szimulátort, várd meg a bootot
flutter devices            # listázza a bebootolt szimulátort
flutter run                # fordít és feltelepít a szimulátorra
```

Csak buildelni (futtatás nélkül), a `.app` a
`build/ios/iphonesimulator/Runner.app` alatt jön létre:

```bash
flutter build ios --simulator
```

### B) A CI által gyártott build futtatása szimulátoron

A GitHub Actions **szimulátor-buildet** készít (`flutter build ios --simulator`),
és a `Runner.app`-ot zipbe csomagolva tölti fel `ios-app-simulator` artifactként.

1. Actions → a legutóbbi futás → **Summary** alján az **Artifacts** szekció →
   töltsd le az `ios-app-simulator` elemet.
2. Kicsomagolás és telepítés (a GitHub egy extra zip-réteget rak rá, ezért
   kétszer csomagolsz ki):

```bash
cd ~/Downloads
unzip ios-app-simulator.zip     # ebből jön a Runner-simulator.zip
unzip Runner-simulator.zip      # ebből a Runner.app mappa

open -a Simulator               # indíts egy szimulátort, várd meg a bootot
xcrun simctl install booted Runner.app
xcrun simctl launch booted com.example.testlab
```

> Ha a `launch` nem találja a bundle ID-t, listázd:
> `xcrun simctl listapps booted | grep -i testlab`, és a kiírt azonosítóval indítsd.

**Fontos:** a `--simulator` build csak **szimulátoron** fut, valódi iPhone-on
nem. A `--release --no-codesign` build ezzel szemben *eszköz*-build (arm64),
ami sem szimulátoron, sem aláírás nélkül valódi telefonon nem indul. Valódi
eszközre aláírt build (`.ipa`) kell — lásd az `ios-release.yml` workflow-t.

## Bejelentkezési adatok

Bármilyen **érvényes email formátum** + **legalább 6 karakteres jelszó**.
Nincs valódi backend, minden lokálisan, determinisztikusan fut.